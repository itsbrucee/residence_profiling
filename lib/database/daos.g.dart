// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daos.dart';

// ignore_for_file: type=lint
mixin _$ResidenceProfileDaoMixin on DatabaseAccessor<AppDatabase> {
  $ResidenceProfilesTable get residenceProfiles =>
      attachedDatabase.residenceProfiles;
  ResidenceProfileDaoManager get managers => ResidenceProfileDaoManager(this);
}

class ResidenceProfileDaoManager {
  final _$ResidenceProfileDaoMixin _db;
  ResidenceProfileDaoManager(this._db);
  $$ResidenceProfilesTableTableManager get residenceProfiles =>
      $$ResidenceProfilesTableTableManager(
        _db.attachedDatabase,
        _db.residenceProfiles,
      );
}
