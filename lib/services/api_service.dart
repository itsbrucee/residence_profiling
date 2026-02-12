import 'package:postgres/postgres.dart';
import '../database/database.dart';

class ApiService {
  // Neon PostgreSQL connection details
  static const String host = 'ep-dark-lab-ai9vq796-pooler.c-4.us-east-1.aws.neon.tech';
  static const int port = 5432;
  static const String database = 'neondb';
  static const String username = 'neondb_owner';
  static const String password = 'npg_azBtUTsW8wJ2';

  Future<bool> isServerReachable() async {
    // Since direct DB connection, check if we can connect briefly
    try {
      final connection = PostgreSQLConnection(
        host,
        port,
        database,
        username: username,
        password: password,
        useSSL: true,
      );
      await connection.open();
      await connection.close();
      return true;
    } catch (e) {
      print('⚠️ Database connection check failed: $e');
      return false;
    }
  }

  Future<bool> uploadProfile(ResidenceProfile profile) async {
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

      // Check if profile already exists
      final checkResult = await connection.query(
        '''
        SELECT id FROM residence_profiles
        WHERE first_name = @firstName AND last_name = @lastName AND birth_date = @birthDate
        ''',
        substitutionValues: {
          'firstName': profile.firstName,
          'lastName': profile.lastName,
          'birthDate': profile.birthDate.toIso8601String().split('T')[0], // YYYY-MM-DD
        },
      );

      if (checkResult.isNotEmpty) {
        print('Profile already exists with ID: ${checkResult.first[0]}');
        return true; // Consider as success
      }

      // Insert new profile
      await connection.query(
        '''
        INSERT INTO residence_profiles (
          first_name, middle_name, last_name, blood_type, sex, marital_status,
          name_extension, educational_attainment, birth_place, birth_date,
          latitude, longitude, photo_path
        ) VALUES (
          @firstName, @middleName, @lastName, @bloodType, @sex, @maritalStatus,
          @nameExtension, @educationalAttainment, @birthPlace, @birthDate,
          @latitude, @longitude, @photoPath
        )
        ''',
        substitutionValues: {
          'firstName': profile.firstName,
          'middleName': profile.middleName,
          'lastName': profile.lastName,
          'bloodType': profile.bloodType,
          'sex': profile.sex,
          'maritalStatus': profile.maritalStatus,
          'nameExtension': profile.nameExtension,
          'educationalAttainment': profile.educationalAttainment,
          'birthPlace': profile.birthPlace,
          'birthDate': profile.birthDate.toIso8601String().split('T')[0], // YYYY-MM-DD
          'latitude': profile.latitude,
          'longitude': profile.longitude,
          'photoPath': profile.photoPath,
        },
      );

      print('✅ Profile uploaded successfully to PostgreSQL');
      return true;
    } catch (e) {
      print('❌ Database error: $e');
      rethrow;
    } finally {
      if (connection != null) {
        await connection.close();
      }
    }
  }
}
