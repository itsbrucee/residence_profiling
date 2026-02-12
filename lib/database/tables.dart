import 'package:drift/drift.dart';

class ResidenceProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get middleName => text().nullable()();
  TextColumn get lastName => text()();
  TextColumn get bloodType => text().nullable()();
  TextColumn get sex => text()();
  TextColumn get maritalStatus => text()();
  TextColumn get nameExtension => text().nullable()();
  TextColumn get educationalAttainment => text()();
  TextColumn get birthPlace => text()();
  DateTimeColumn get birthDate => dateTime()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get photoPath => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
