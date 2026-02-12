
part of 'database.dart';

// ignore_for_file: type=lint
class $ResidenceProfilesTable extends ResidenceProfiles
    with TableInfo<$ResidenceProfilesTable, ResidenceProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResidenceProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _middleNameMeta = const VerificationMeta(
    'middleName',
  );
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
    'middle_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodTypeMeta = const VerificationMeta(
    'bloodType',
  );
  @override
  late final GeneratedColumn<String> bloodType = GeneratedColumn<String>(
    'blood_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maritalStatusMeta = const VerificationMeta(
    'maritalStatus',
  );
  @override
  late final GeneratedColumn<String> maritalStatus = GeneratedColumn<String>(
    'marital_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameExtensionMeta = const VerificationMeta(
    'nameExtension',
  );
  @override
  late final GeneratedColumn<String> nameExtension = GeneratedColumn<String>(
    'name_extension',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _educationalAttainmentMeta =
      const VerificationMeta('educationalAttainment');
  @override
  late final GeneratedColumn<String> educationalAttainment =
      GeneratedColumn<String>(
        'educational_attainment',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _birthPlaceMeta = const VerificationMeta(
    'birthPlace',
  );
  @override
  late final GeneratedColumn<String> birthPlace = GeneratedColumn<String>(
    'birth_place',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    middleName,
    lastName,
    bloodType,
    sex,
    maritalStatus,
    nameExtension,
    educationalAttainment,
    birthPlace,
    birthDate,
    latitude,
    longitude,
    photoPath,
    isSynced,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'residence_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ResidenceProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
        _middleNameMeta,
        middleName.isAcceptableOrUnknown(data['middle_name']!, _middleNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('blood_type')) {
      context.handle(
        _bloodTypeMeta,
        bloodType.isAcceptableOrUnknown(data['blood_type']!, _bloodTypeMeta),
      );
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    } else if (isInserting) {
      context.missing(_sexMeta);
    }
    if (data.containsKey('marital_status')) {
      context.handle(
        _maritalStatusMeta,
        maritalStatus.isAcceptableOrUnknown(
          data['marital_status']!,
          _maritalStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maritalStatusMeta);
    }
    if (data.containsKey('name_extension')) {
      context.handle(
        _nameExtensionMeta,
        nameExtension.isAcceptableOrUnknown(
          data['name_extension']!,
          _nameExtensionMeta,
        ),
      );
    }
    if (data.containsKey('educational_attainment')) {
      context.handle(
        _educationalAttainmentMeta,
        educationalAttainment.isAcceptableOrUnknown(
          data['educational_attainment']!,
          _educationalAttainmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_educationalAttainmentMeta);
    }
    if (data.containsKey('birth_place')) {
      context.handle(
        _birthPlaceMeta,
        birthPlace.isAcceptableOrUnknown(data['birth_place']!, _birthPlaceMeta),
      );
    } else if (isInserting) {
      context.missing(_birthPlaceMeta);
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    } else if (isInserting) {
      context.missing(_birthDateMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ResidenceProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ResidenceProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      middleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}middle_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      bloodType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_type'],
      ),
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      maritalStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marital_status'],
      )!,
      nameExtension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_extension'],
      ),
      educationalAttainment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}educational_attainment'],
      )!,
      birthPlace: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_place'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ResidenceProfilesTable createAlias(String alias) {
    return $ResidenceProfilesTable(attachedDatabase, alias);
  }
}

class ResidenceProfile extends DataClass
    implements Insertable<ResidenceProfile> {
  final int id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? bloodType;
  final String sex;
  final String maritalStatus;
  final String? nameExtension;
  final String educationalAttainment;
  final String birthPlace;
  final DateTime birthDate;
  final double? latitude;
  final double? longitude;
  final String? photoPath;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ResidenceProfile({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.bloodType,
    required this.sex,
    required this.maritalStatus,
    this.nameExtension,
    required this.educationalAttainment,
    required this.birthPlace,
    required this.birthDate,
    this.latitude,
    this.longitude,
    this.photoPath,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    if (!nullToAbsent || middleName != null) {
      map['middle_name'] = Variable<String>(middleName);
    }
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || bloodType != null) {
      map['blood_type'] = Variable<String>(bloodType);
    }
    map['sex'] = Variable<String>(sex);
    map['marital_status'] = Variable<String>(maritalStatus);
    if (!nullToAbsent || nameExtension != null) {
      map['name_extension'] = Variable<String>(nameExtension);
    }
    map['educational_attainment'] = Variable<String>(educationalAttainment);
    map['birth_place'] = Variable<String>(birthPlace);
    map['birth_date'] = Variable<DateTime>(birthDate);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ResidenceProfilesCompanion toCompanion(bool nullToAbsent) {
    return ResidenceProfilesCompanion(
      id: Value(id),
      firstName: Value(firstName),
      middleName: middleName == null && nullToAbsent
          ? const Value.absent()
          : Value(middleName),
      lastName: Value(lastName),
      bloodType: bloodType == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodType),
      sex: Value(sex),
      maritalStatus: Value(maritalStatus),
      nameExtension: nameExtension == null && nullToAbsent
          ? const Value.absent()
          : Value(nameExtension),
      educationalAttainment: Value(educationalAttainment),
      birthPlace: Value(birthPlace),
      birthDate: Value(birthDate),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ResidenceProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ResidenceProfile(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      middleName: serializer.fromJson<String?>(json['middleName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      bloodType: serializer.fromJson<String?>(json['bloodType']),
      sex: serializer.fromJson<String>(json['sex']),
      maritalStatus: serializer.fromJson<String>(json['maritalStatus']),
      nameExtension: serializer.fromJson<String?>(json['nameExtension']),
      educationalAttainment: serializer.fromJson<String>(
        json['educationalAttainment'],
      ),
      birthPlace: serializer.fromJson<String>(json['birthPlace']),
      birthDate: serializer.fromJson<DateTime>(json['birthDate']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'middleName': serializer.toJson<String?>(middleName),
      'lastName': serializer.toJson<String>(lastName),
      'bloodType': serializer.toJson<String?>(bloodType),
      'sex': serializer.toJson<String>(sex),
      'maritalStatus': serializer.toJson<String>(maritalStatus),
      'nameExtension': serializer.toJson<String?>(nameExtension),
      'educationalAttainment': serializer.toJson<String>(educationalAttainment),
      'birthPlace': serializer.toJson<String>(birthPlace),
      'birthDate': serializer.toJson<DateTime>(birthDate),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'photoPath': serializer.toJson<String?>(photoPath),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ResidenceProfile copyWith({
    int? id,
    String? firstName,
    Value<String?> middleName = const Value.absent(),
    String? lastName,
    Value<String?> bloodType = const Value.absent(),
    String? sex,
    String? maritalStatus,
    Value<String?> nameExtension = const Value.absent(),
    String? educationalAttainment,
    String? birthPlace,
    DateTime? birthDate,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ResidenceProfile(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    middleName: middleName.present ? middleName.value : this.middleName,
    lastName: lastName ?? this.lastName,
    bloodType: bloodType.present ? bloodType.value : this.bloodType,
    sex: sex ?? this.sex,
    maritalStatus: maritalStatus ?? this.maritalStatus,
    nameExtension: nameExtension.present
        ? nameExtension.value
        : this.nameExtension,
    educationalAttainment: educationalAttainment ?? this.educationalAttainment,
    birthPlace: birthPlace ?? this.birthPlace,
    birthDate: birthDate ?? this.birthDate,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ResidenceProfile copyWithCompanion(ResidenceProfilesCompanion data) {
    return ResidenceProfile(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      middleName: data.middleName.present
          ? data.middleName.value
          : this.middleName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      bloodType: data.bloodType.present ? data.bloodType.value : this.bloodType,
      sex: data.sex.present ? data.sex.value : this.sex,
      maritalStatus: data.maritalStatus.present
          ? data.maritalStatus.value
          : this.maritalStatus,
      nameExtension: data.nameExtension.present
          ? data.nameExtension.value
          : this.nameExtension,
      educationalAttainment: data.educationalAttainment.present
          ? data.educationalAttainment.value
          : this.educationalAttainment,
      birthPlace: data.birthPlace.present
          ? data.birthPlace.value
          : this.birthPlace,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ResidenceProfile(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('bloodType: $bloodType, ')
          ..write('sex: $sex, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('nameExtension: $nameExtension, ')
          ..write('educationalAttainment: $educationalAttainment, ')
          ..write('birthPlace: $birthPlace, ')
          ..write('birthDate: $birthDate, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    middleName,
    lastName,
    bloodType,
    sex,
    maritalStatus,
    nameExtension,
    educationalAttainment,
    birthPlace,
    birthDate,
    latitude,
    longitude,
    photoPath,
    isSynced,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResidenceProfile &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.middleName == this.middleName &&
          other.lastName == this.lastName &&
          other.bloodType == this.bloodType &&
          other.sex == this.sex &&
          other.maritalStatus == this.maritalStatus &&
          other.nameExtension == this.nameExtension &&
          other.educationalAttainment == this.educationalAttainment &&
          other.birthPlace == this.birthPlace &&
          other.birthDate == this.birthDate &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.photoPath == this.photoPath &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ResidenceProfilesCompanion extends UpdateCompanion<ResidenceProfile> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String?> middleName;
  final Value<String> lastName;
  final Value<String?> bloodType;
  final Value<String> sex;
  final Value<String> maritalStatus;
  final Value<String?> nameExtension;
  final Value<String> educationalAttainment;
  final Value<String> birthPlace;
  final Value<DateTime> birthDate;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> photoPath;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ResidenceProfilesCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.bloodType = const Value.absent(),
    this.sex = const Value.absent(),
    this.maritalStatus = const Value.absent(),
    this.nameExtension = const Value.absent(),
    this.educationalAttainment = const Value.absent(),
    this.birthPlace = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ResidenceProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    this.middleName = const Value.absent(),
    required String lastName,
    this.bloodType = const Value.absent(),
    required String sex,
    required String maritalStatus,
    this.nameExtension = const Value.absent(),
    required String educationalAttainment,
    required String birthPlace,
    required DateTime birthDate,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       sex = Value(sex),
       maritalStatus = Value(maritalStatus),
       educationalAttainment = Value(educationalAttainment),
       birthPlace = Value(birthPlace),
       birthDate = Value(birthDate);
  static Insertable<ResidenceProfile> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? middleName,
    Expression<String>? lastName,
    Expression<String>? bloodType,
    Expression<String>? sex,
    Expression<String>? maritalStatus,
    Expression<String>? nameExtension,
    Expression<String>? educationalAttainment,
    Expression<String>? birthPlace,
    Expression<DateTime>? birthDate,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? photoPath,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (middleName != null) 'middle_name': middleName,
      if (lastName != null) 'last_name': lastName,
      if (bloodType != null) 'blood_type': bloodType,
      if (sex != null) 'sex': sex,
      if (maritalStatus != null) 'marital_status': maritalStatus,
      if (nameExtension != null) 'name_extension': nameExtension,
      if (educationalAttainment != null)
        'educational_attainment': educationalAttainment,
      if (birthPlace != null) 'birth_place': birthPlace,
      if (birthDate != null) 'birth_date': birthDate,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (photoPath != null) 'photo_path': photoPath,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ResidenceProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String?>? middleName,
    Value<String>? lastName,
    Value<String?>? bloodType,
    Value<String>? sex,
    Value<String>? maritalStatus,
    Value<String?>? nameExtension,
    Value<String>? educationalAttainment,
    Value<String>? birthPlace,
    Value<DateTime>? birthDate,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? photoPath,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ResidenceProfilesCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      bloodType: bloodType ?? this.bloodType,
      sex: sex ?? this.sex,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      nameExtension: nameExtension ?? this.nameExtension,
      educationalAttainment:
          educationalAttainment ?? this.educationalAttainment,
      birthPlace: birthPlace ?? this.birthPlace,
      birthDate: birthDate ?? this.birthDate,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      photoPath: photoPath ?? this.photoPath,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (bloodType.present) {
      map['blood_type'] = Variable<String>(bloodType.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (maritalStatus.present) {
      map['marital_status'] = Variable<String>(maritalStatus.value);
    }
    if (nameExtension.present) {
      map['name_extension'] = Variable<String>(nameExtension.value);
    }
    if (educationalAttainment.present) {
      map['educational_attainment'] = Variable<String>(
        educationalAttainment.value,
      );
    }
    if (birthPlace.present) {
      map['birth_place'] = Variable<String>(birthPlace.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResidenceProfilesCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('middleName: $middleName, ')
          ..write('lastName: $lastName, ')
          ..write('bloodType: $bloodType, ')
          ..write('sex: $sex, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('nameExtension: $nameExtension, ')
          ..write('educationalAttainment: $educationalAttainment, ')
          ..write('birthPlace: $birthPlace, ')
          ..write('birthDate: $birthDate, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('photoPath: $photoPath, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ResidenceProfilesTable residenceProfiles =
      $ResidenceProfilesTable(this);
  late final ResidenceProfileDao residenceProfileDao = ResidenceProfileDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [residenceProfiles];
}

typedef $$ResidenceProfilesTableCreateCompanionBuilder =
    ResidenceProfilesCompanion Function({
      Value<int> id,
      required String firstName,
      Value<String?> middleName,
      required String lastName,
      Value<String?> bloodType,
      required String sex,
      required String maritalStatus,
      Value<String?> nameExtension,
      required String educationalAttainment,
      required String birthPlace,
      required DateTime birthDate,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> photoPath,
      Value<bool> isSynced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ResidenceProfilesTableUpdateCompanionBuilder =
    ResidenceProfilesCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String?> middleName,
      Value<String> lastName,
      Value<String?> bloodType,
      Value<String> sex,
      Value<String> maritalStatus,
      Value<String?> nameExtension,
      Value<String> educationalAttainment,
      Value<String> birthPlace,
      Value<DateTime> birthDate,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> photoPath,
      Value<bool> isSynced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ResidenceProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ResidenceProfilesTable> {
  $$ResidenceProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maritalStatus => $composableBuilder(
    column: $table.maritalStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameExtension => $composableBuilder(
    column: $table.nameExtension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get educationalAttainment => $composableBuilder(
    column: $table.educationalAttainment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthPlace => $composableBuilder(
    column: $table.birthPlace,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ResidenceProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ResidenceProfilesTable> {
  $$ResidenceProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maritalStatus => $composableBuilder(
    column: $table.maritalStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameExtension => $composableBuilder(
    column: $table.nameExtension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get educationalAttainment => $composableBuilder(
    column: $table.educationalAttainment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthPlace => $composableBuilder(
    column: $table.birthPlace,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResidenceProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResidenceProfilesTable> {
  $$ResidenceProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get bloodType =>
      $composableBuilder(column: $table.bloodType, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get maritalStatus => $composableBuilder(
    column: $table.maritalStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameExtension => $composableBuilder(
    column: $table.nameExtension,
    builder: (column) => column,
  );

  GeneratedColumn<String> get educationalAttainment => $composableBuilder(
    column: $table.educationalAttainment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get birthPlace => $composableBuilder(
    column: $table.birthPlace,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ResidenceProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResidenceProfilesTable,
          ResidenceProfile,
          $$ResidenceProfilesTableFilterComposer,
          $$ResidenceProfilesTableOrderingComposer,
          $$ResidenceProfilesTableAnnotationComposer,
          $$ResidenceProfilesTableCreateCompanionBuilder,
          $$ResidenceProfilesTableUpdateCompanionBuilder,
          (
            ResidenceProfile,
            BaseReferences<
              _$AppDatabase,
              $ResidenceProfilesTable,
              ResidenceProfile
            >,
          ),
          ResidenceProfile,
          PrefetchHooks Function()
        > {
  $$ResidenceProfilesTableTableManager(
    _$AppDatabase db,
    $ResidenceProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResidenceProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResidenceProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResidenceProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String?> middleName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> bloodType = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String> maritalStatus = const Value.absent(),
                Value<String?> nameExtension = const Value.absent(),
                Value<String> educationalAttainment = const Value.absent(),
                Value<String> birthPlace = const Value.absent(),
                Value<DateTime> birthDate = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ResidenceProfilesCompanion(
                id: id,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                bloodType: bloodType,
                sex: sex,
                maritalStatus: maritalStatus,
                nameExtension: nameExtension,
                educationalAttainment: educationalAttainment,
                birthPlace: birthPlace,
                birthDate: birthDate,
                latitude: latitude,
                longitude: longitude,
                photoPath: photoPath,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                Value<String?> middleName = const Value.absent(),
                required String lastName,
                Value<String?> bloodType = const Value.absent(),
                required String sex,
                required String maritalStatus,
                Value<String?> nameExtension = const Value.absent(),
                required String educationalAttainment,
                required String birthPlace,
                required DateTime birthDate,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ResidenceProfilesCompanion.insert(
                id: id,
                firstName: firstName,
                middleName: middleName,
                lastName: lastName,
                bloodType: bloodType,
                sex: sex,
                maritalStatus: maritalStatus,
                nameExtension: nameExtension,
                educationalAttainment: educationalAttainment,
                birthPlace: birthPlace,
                birthDate: birthDate,
                latitude: latitude,
                longitude: longitude,
                photoPath: photoPath,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ResidenceProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResidenceProfilesTable,
      ResidenceProfile,
      $$ResidenceProfilesTableFilterComposer,
      $$ResidenceProfilesTableOrderingComposer,
      $$ResidenceProfilesTableAnnotationComposer,
      $$ResidenceProfilesTableCreateCompanionBuilder,
      $$ResidenceProfilesTableUpdateCompanionBuilder,
      (
        ResidenceProfile,
        BaseReferences<
          _$AppDatabase,
          $ResidenceProfilesTable,
          ResidenceProfile
        >,
      ),
      ResidenceProfile,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ResidenceProfilesTableTableManager get residenceProfiles =>
      $$ResidenceProfilesTableTableManager(_db, _db.residenceProfiles);
}
