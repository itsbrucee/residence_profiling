import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:drift/drift.dart' hide Column;
import '../database/database.dart';
import '../database/tables.dart';
import '../services/api_service.dart';
import '../services/connectivity_service.dart';
import '../pages/step_page.dart';

class ResidenceProfilingForm extends StatefulWidget {
  final ResidenceProfile? profileToEdit;
  final AppDatabase database;

  const ResidenceProfilingForm({super.key, this.profileToEdit, required this.database});

  @override
  State<ResidenceProfilingForm> createState() => _ResidenceProfilingFormState();
}

class _ResidenceProfilingFormState extends State<ResidenceProfilingForm> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  // Form data
  String firstName = '';
  String middleName = '';
  String lastName = '';
  String bloodType = '';
  String sex = '';
  String maritalStatus = '';
  String nameExtension = '';
  String educationalAttainment = '';
  String birthPlace = '';
  DateTime? birthDate;
  double? latitude;
  double? longitude;
  String? photoPath;

  // Services
  late final AppDatabase _database;
  final ApiService _apiService = ApiService();
  final ConnectivityService _connectivityService = ConnectivityService();

  // Step management
  int _currentStep = 0;
  final int _totalSteps = 12;

  final List<String> _stepTitles = [
    'First Name',
    'Middle Name',
    'Last Name',
    'Blood Type',
    'Sex',
    'Marital Status',
    'Name Extension',
    'Educational Attainment',
    'Birth Place',
    'Birth Date',
    'Coordinates',
    'Upload Photo',
  ];

  @override
  void initState() {
    super.initState();
    _database = widget.database;
    if (widget.profileToEdit != null) {
      final profile = widget.profileToEdit!;
      firstName = profile.firstName;
      middleName = profile.middleName ?? '';
      lastName = profile.lastName;
      bloodType = profile.bloodType ?? '';
      sex = profile.sex;
      maritalStatus = profile.maritalStatus;
      nameExtension = profile.nameExtension ?? '';
      educationalAttainment = profile.educationalAttainment;
      birthPlace = profile.birthPlace;
      birthDate = profile.birthDate;
      latitude = profile.latitude;
      longitude = profile.longitude;
      photoPath = profile.photoPath;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_formKey.currentState?.validate() ?? true) {
      if (_currentStep < _totalSteps - 1) {
        setState(() {
          _currentStep++;
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        _finishForm();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finishForm() async {
    // Show dialog for Save, Save Draft, Discard
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finish Profiling'),
        content: const Text('What would you like to do?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop('discard'),
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop('draft'),
            child: const Text('Save Draft'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop('save'),
            child: const Text('Save'),
          ),
        ],
      ),
    ).then((result) async {
      if (result == 'save') {
        await _saveProfile();
      } else if (result == 'draft') {
        await _saveDraft();
      } else if (result == 'discard') {
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> _saveProfile() async {
    if (widget.profileToEdit != null) {
      // Update existing profile
      final updatedProfile = ResidenceProfile(
        id: widget.profileToEdit!.id,
        firstName: firstName,
        middleName: middleName.isEmpty ? null : middleName,
        lastName: lastName,
        bloodType: bloodType.isEmpty ? null : bloodType,
        sex: sex,
        maritalStatus: maritalStatus,
        nameExtension: nameExtension.isEmpty ? null : nameExtension,
        educationalAttainment: educationalAttainment,
        birthPlace: birthPlace,
        birthDate: birthDate!,
        latitude: latitude,
        longitude: longitude,
        photoPath: photoPath,
        isSynced: true,
        createdAt: widget.profileToEdit!.createdAt,
        updatedAt: DateTime.now(),
      );
      await _database.residenceProfileDao.updateProfile(updatedProfile);

      // Try to upload if server reachable
      final isReachable = await _apiService.isServerReachable();
      if (isReachable) {
        await _uploadProfiles();
      }

      if (mounted) {
        _showSuccessSnackBar('Resident saved successfully!');
        Navigator.of(context).pop();
      }
    } else {
      // Insert new profile
      final profile = ResidenceProfilesCompanion(
        firstName: Value(firstName),
        middleName: Value(middleName),
        lastName: Value(lastName),
        bloodType: Value(bloodType),
        sex: Value(sex),
        maritalStatus: Value(maritalStatus),
        nameExtension: Value(nameExtension),
        educationalAttainment: Value(educationalAttainment),
        birthPlace: Value(birthPlace),
        birthDate: Value(birthDate!),
        latitude: Value(latitude),
        longitude: Value(longitude),
        photoPath: Value(photoPath),
        isSynced: const Value(true),
      );

      int id = await _database.residenceProfileDao.insertProfile(profile);

      // Try to upload if server reachable
      final isReachable = await _apiService.isServerReachable();
      if (isReachable) {
        await _uploadProfiles();
      }

      if (mounted) {
        _showSuccessSnackBar('Resident saved successfully!');
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _saveDraft() async {
    if (widget.profileToEdit != null) {
      // Update existing profile as draft
      final updatedProfile = ResidenceProfile(
        id: widget.profileToEdit!.id,
        firstName: firstName,
        middleName: middleName.isEmpty ? null : middleName,
        lastName: lastName,
        bloodType: bloodType.isEmpty ? null : bloodType,
        sex: sex,
        maritalStatus: maritalStatus,
        nameExtension: nameExtension.isEmpty ? null : nameExtension,
        educationalAttainment: educationalAttainment,
        birthPlace: birthPlace,
        birthDate: birthDate!,
        latitude: latitude,
        longitude: longitude,
        photoPath: photoPath,
        isSynced: false,
        createdAt: widget.profileToEdit!.createdAt,
        updatedAt: DateTime.now(),
      );
      await _database.residenceProfileDao.updateProfile(updatedProfile);

      if (mounted) {
        _showSuccessSnackBar('Resident saved as draft!');
        Navigator.of(context).pop();
      }
    } else {
      // Insert new draft
      final profile = ResidenceProfilesCompanion(
        firstName: Value(firstName),
        middleName: Value(middleName),
        lastName: Value(lastName),
        bloodType: Value(bloodType),
        sex: Value(sex),
        maritalStatus: Value(maritalStatus),
        nameExtension: Value(nameExtension),
        educationalAttainment: Value(educationalAttainment),
        birthPlace: Value(birthPlace),
        birthDate: birthDate != null ? Value(birthDate!) : const Value.absent(),
        latitude: Value(latitude),
        longitude: Value(longitude),
        photoPath: Value(photoPath),
        isSynced: const Value(false),
      );

      await _database.residenceProfileDao.insertProfile(profile);

      if (mounted) {
        _showSuccessSnackBar('Resident saved as draft!');
        Navigator.of(context).pop();
      }
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 6,
      ),
    );
  }

  Future<void> _uploadProfiles() async {
    final unsyncedProfiles = await _database.residenceProfileDao.getUnsyncedProfiles();

    for (final profile in unsyncedProfiles) {
      try {
        await _apiService.uploadProfile(profile);
        await _database.residenceProfileDao.deleteProfile(profile.id);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Uploaded successfully')),
          );
        }
      } catch (e) {
        // Handle upload error
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Upload failed: ${e.toString()}')),
          );
        }
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to get location: $e')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        photoPath = pickedFile.path;
      });
    }
  }

  Widget _buildModernInputContainer({required Widget child}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: child,
      ),
    );
  }

  Widget _buildStepContent(int stepIndex) {
    switch (stepIndex) {
      case 0:
        return _buildModernInputContainer(
          child: TextFormField(
            key: ValueKey(stepIndex),
            controller: TextEditingController(text: firstName),
            decoration: InputDecoration(
              label: Text.rich(TextSpan(
                text: 'First Name',
                children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
              )),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            onChanged: (value) => firstName = value,
          ),
        );
      case 1:
        return _buildModernInputContainer(
          child: TextFormField(
            key: ValueKey(stepIndex),
            controller: TextEditingController(text: middleName),
            decoration: const InputDecoration(
              labelText: 'Middle Name',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) => middleName = value,
          ),
        );
      case 2:
        return _buildModernInputContainer(
          child: TextFormField(
            key: ValueKey(stepIndex),
            controller: TextEditingController(text: lastName),
            decoration: InputDecoration(
              label: Text.rich(TextSpan(
                text: 'Last Name',
                children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
              )),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            onChanged: (value) => lastName = value,
          ),
        );
      case 3:
        return _buildModernInputContainer(
          child: DropdownButtonFormField<String>(
            value: bloodType.isEmpty ? null : bloodType,
            decoration: const InputDecoration(
              labelText: 'Blood Type',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            items: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) => bloodType = value ?? '',
          ),
        );
      case 4:
        return _buildModernInputContainer(
          child: DropdownButtonFormField<String>(
            value: sex.isEmpty ? null : sex,
            decoration: InputDecoration(
              label: Text.rich(TextSpan(
                text: 'Sex',
                children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
              )),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            items: ['Male', 'Female']
                .map((sex) => DropdownMenuItem(value: sex, child: Text(sex)))
                .toList(),
            validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            onChanged: (value) => sex = value ?? '',
          ),
        );
      case 5:
        return _buildModernInputContainer(
          child: DropdownButtonFormField<String>(
            value: maritalStatus.isEmpty ? null : maritalStatus,
            decoration: const InputDecoration(
              labelText: 'Marital Status',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            items: ['Single', 'Married', 'Widowed', 'Divorced']
                .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                .toList(),
            onChanged: (value) => maritalStatus = value ?? '',
          ),
        );
      case 6:
        return _buildModernInputContainer(
          child: TextFormField(
            key: ValueKey(stepIndex),
            controller: TextEditingController(text: nameExtension),
            decoration: const InputDecoration(
              labelText: 'Name Extension',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) => nameExtension = value,
          ),
        );
      case 7:
        return _buildModernInputContainer(
          child: DropdownButtonFormField<String>(
            value: educationalAttainment.isEmpty ? null : educationalAttainment,
            decoration: const InputDecoration(
              labelText: 'Educational Attainment',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            items: ['Elementary', 'High School', 'College', 'Post Graduate']
                .map((level) => DropdownMenuItem(value: level, child: Text(level)))
                .toList(),
            onChanged: (value) => educationalAttainment = value ?? '',
          ),
        );
      case 8:
        return _buildModernInputContainer(
          child: TextFormField(
            key: ValueKey(stepIndex),
            controller: TextEditingController(text: birthPlace),
            decoration: const InputDecoration(
              labelText: 'Birth Place',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) => birthPlace = value,
          ),
        );
      case 9:
        return _buildModernInputContainer(
          child: TextFormField(
            key: ValueKey(stepIndex),
            readOnly: true,
            decoration: InputDecoration(
              label: Text.rich(TextSpan(
                text: 'Birth Date',
                children: [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
              )),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            controller: TextEditingController(
              text: birthDate != null
                  ? '${birthDate!.day}/${birthDate!.month}/${birthDate!.year}'
                  : '',
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (date != null) {
                setState(() {
                  birthDate = date;
                });
              }
            },
            validator: (value) => birthDate == null ? 'Required' : null,
          ),
        );
      case 10:
        return Column(
          children: [
            _buildModernInputContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(Icons.location_on),
                    label: const Text('Get Current Location'),
                  ),
                  if (latitude != null && longitude != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Latitude: ${latitude!.toStringAsFixed(6)}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Longitude: ${longitude!.toStringAsFixed(6)}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      case 11:
        return Column(
          children: [
            _buildModernInputContainer(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                  ),
                  if (photoPath != null) ...[
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(File(photoPath!), height: 150),
                    ),
                  ],
                ],
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _totalSteps,
        itemBuilder: (context, index) {
          return StepPage(
            title: _stepTitles[index],
            content: Form(
              key: _formKey,
              child: _buildStepContent(index),
            ),
            onNext: _nextStep,
            onBack: _currentStep > 0 ? _previousStep : null,
            isLastStep: index == _totalSteps - 1,
          );
        },
      ),
    );
  }
}
