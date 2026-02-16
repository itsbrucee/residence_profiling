import 'package:postgres/postgres.dart';
import '../database/database.dart';

class DuplicateDetectionService {
  // Neon PostgreSQL connection details (same as ApiService)
  static const String host = 'ep-dark-lab-ai9vq796-pooler.c-4.us-east-1.aws.neon.tech';
  static const int port = 5432;
  static const String database = 'neondb';
  static const String username = 'neondb_owner';
  static const String password = 'npg_azBtUTsW8wJ2';

  /// Checks for duplicate residents based on all required fields
  /// Returns null if no duplicate found, or a message if duplicate exists
  Future<String?> checkForDuplicate({
    required String firstName,
    required String middleName,
    required String lastName,
    required String nameExtension,
    required DateTime birthDate,
    required String birthPlace,
    required String sex,
    required AppDatabase database,
    int? excludeId, // Exclude a specific ID (when editing)
  }) async {
    // First check offline (local database)
    final offlineDuplicate = await _checkOfflineDuplicate(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      nameExtension: nameExtension,
      birthDate: birthDate,
      birthPlace: birthPlace,
      sex: sex,
      database: database,
      excludeId: excludeId,
    );

    if (offlineDuplicate) {
      return 'Resident already exists in the list.';
    }

    // Then check online (PostgreSQL database)
    final onlineDuplicate = await _checkOnlineDuplicate(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      nameExtension: nameExtension,
      birthDate: birthDate,
      birthPlace: birthPlace,
      sex: sex,
    );

    if (onlineDuplicate) {
      return 'Resident already exists in the list.';
    }

    return null; // No duplicate found
  }

  /// Checks for duplicates in offline (local SQLite) database
  /// Includes both saved (isSynced=true) and draft (isSynced=false) records
  Future<bool> _checkOfflineDuplicate({
    required String firstName,
    required String middleName,
    required String lastName,
    required String nameExtension,
    required DateTime birthDate,
    required String birthPlace,
    required String sex,
    required AppDatabase database,
    int? excludeId,
  }) async {
    try {
      final allProfiles = await database.residenceProfileDao.getAllProfiles();

      for (final profile in allProfiles) {
        // Skip if this is the same record being edited
        if (excludeId != null && profile.id == excludeId) {
          continue;
        }

        // Check if all fields match
        if (_fieldsMatch(
          profile,
          firstName: firstName,
          middleName: middleName,
          lastName: lastName,
          nameExtension: nameExtension,
          birthDate: birthDate,
          birthPlace: birthPlace,
          sex: sex,
        )) {
          return true;
        }
      }

      return false;
    } catch (e) {
      print('⚠️ Error checking offline duplicates: $e');
      return false;
    }
  }

  /// Checks for duplicates in online PostgreSQL database
  Future<bool> _checkOnlineDuplicate({
    required String firstName,
    required String middleName,
    required String lastName,
    required String nameExtension,
    required DateTime birthDate,
    required String birthPlace,
    required String sex,
  }) async {
    PostgreSQLConnection? connection;
    try {
      connection = PostgreSQLConnection(
        host,
        port,
        database,
        username: username,
        password: password,
        useSSL: true,
      );
      await connection.open();

      // Query for matching record - all 7 fields must match
      final result = await connection.query(
        '''
        SELECT id FROM residence_profiles
        WHERE LOWER(TRIM(first_name)) = LOWER(TRIM(@firstName))
          AND LOWER(TRIM(COALESCE(middle_name, ''))) = LOWER(TRIM(COALESCE(@middleName, '')))
          AND LOWER(TRIM(last_name)) = LOWER(TRIM(@lastName))
          AND LOWER(TRIM(COALESCE(name_extension, ''))) = LOWER(TRIM(COALESCE(@nameExtension, '')))
          AND birth_date = @birthDate
          AND LOWER(TRIM(birth_place)) = LOWER(TRIM(@birthPlace))
          AND LOWER(TRIM(sex)) = LOWER(TRIM(@sex))
        ''',
        substitutionValues: {
          'firstName': firstName,
          'middleName': middleName,
          'lastName': lastName,
          'nameExtension': nameExtension,
          'birthDate': birthDate.toIso8601String().split('T')[0], // YYYY-MM-DD
          'birthPlace': birthPlace,
          'sex': sex,
        },
      );

      return result.isNotEmpty;
    } catch (e) {
      print('⚠️ Error checking online duplicates: $e');
      // If we can't connect to the database, assume no online duplicates
      // to allow offline operation
      return false;
    } finally {
      if (connection != null) {
        await connection.close();
      }
    }
  }

  /// Compares all required fields between a profile and the input values
  /// Returns true if all fields match (considering case-insensitive and trimmed comparison)
  bool _fieldsMatch(
    ResidenceProfile profile, {
    required String firstName,
    required String middleName,
    required String lastName,
    required String nameExtension,
    required DateTime birthDate,
    required String birthPlace,
    required String sex,
  }) {
    // Case-insensitive and trimmed comparison for text fields
    return _normalizeText(profile.firstName) == _normalizeText(firstName) &&
        _normalizeText(profile.middleName ?? '') == _normalizeText(middleName) &&
        _normalizeText(profile.lastName) == _normalizeText(lastName) &&
        _normalizeText(profile.nameExtension ?? '') == _normalizeText(nameExtension) &&
        profile.birthDate == birthDate &&
        _normalizeText(profile.birthPlace) == _normalizeText(birthPlace) &&
        _normalizeText(profile.sex) == _normalizeText(sex);
  }

  /// Normalizes text for comparison (lowercase, trimmed)
  String _normalizeText(String text) {
    return text.toLowerCase().trim();
  }
}
