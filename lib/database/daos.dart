import 'package:drift/drift.dart';
import 'database.dart';
import 'tables.dart';

part 'daos.g.dart';

@DriftAccessor(tables: [ResidenceProfiles])
class ResidenceProfileDao extends DatabaseAccessor<AppDatabase>
    with _$ResidenceProfileDaoMixin {
  final AppDatabase db;

  ResidenceProfileDao(this.db) : super(db);

  Future<List<ResidenceProfile>> getAllProfiles() => select(residenceProfiles).get();

  Future<List<ResidenceProfile>> getUnsyncedProfiles() =>
      (select(residenceProfiles)..where((tbl) => tbl.isSynced.equals(false))).get();

  Future<List<ResidenceProfile>> getSyncedProfiles() =>
      (select(residenceProfiles)..where((tbl) => tbl.isSynced.equals(true))).get();

  Stream<List<ResidenceProfile>> watchUnsyncedProfiles() =>
      (select(residenceProfiles)..where((tbl) => tbl.isSynced.equals(false))).watch();

  Stream<List<ResidenceProfile>> watchSyncedProfiles() =>
      (select(residenceProfiles)..where((tbl) => tbl.isSynced.equals(true))).watch();

  Future<int> insertProfile(ResidenceProfilesCompanion profile) =>
      into(residenceProfiles).insert(profile);

  Future<bool> updateProfile(ResidenceProfile profile) =>
      update(residenceProfiles).replace(profile);

  Future<int> deleteProfile(int id) =>
      (delete(residenceProfiles)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> markAsSynced(int id) =>
      (update(residenceProfiles)..where((tbl) => tbl.id.equals(id)))
          .write(const ResidenceProfilesCompanion(isSynced: Value(true)));
}
