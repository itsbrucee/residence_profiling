import 'package:flutter/material.dart';
import '../database/database.dart';
import '../services/api_service.dart';
import '../services/connectivity_service.dart';

class ResidentDetailsPage extends StatefulWidget {
  final ResidenceProfile profile;
  final AppDatabase database;
  final bool isFromSavedTab;

  const ResidentDetailsPage({super.key, required this.profile, required this.database, this.isFromSavedTab = false});

  @override
  State<ResidentDetailsPage> createState() => _ResidentDetailsPageState();
}

class _ResidentDetailsPageState extends State<ResidentDetailsPage> {
  late final ApiService _apiService;
  late final ConnectivityService _connectivityService;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _connectivityService = ConnectivityService();
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resident Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card with Image and Name
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: profile.photoPath != null && profile.photoPath!.isNotEmpty
                            ? AssetImage(profile.photoPath!)
                            : null,
                        child: profile.photoPath == null || profile.photoPath!.isEmpty
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey[600],
                              )
                            : null,
                      ),
                      const SizedBox(width: 20),
                      // Name Information
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${profile.firstName} ${profile.middleName ?? ''} ${profile.lastName}${profile.nameExtension != null ? ' ${profile.nameExtension}' : ''}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                profile.sex ?? 'N/A',
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Personal Information Card
              _buildInfoSection(
                title: 'Personal Information',
                children: [
                  _buildInfoRow('Blood Type', profile.bloodType ?? 'N/A'),
                  _buildInfoRow('Sex', profile.sex ?? 'N/A'),
                  _buildInfoRow('Marital Status', profile.maritalStatus ?? 'N/A'),
                ],
              ),
              const SizedBox(height: 16),
              
              // Education Card
              _buildInfoSection(
                title: 'Education',
                children: [
                  _buildInfoRow('Educational Attainment', profile.educationalAttainment ?? 'N/A'),
                ],
              ),
              const SizedBox(height: 16),
              
              // Birth Information Card
              _buildInfoSection(
                title: 'Birth Information',
                children: [
                  _buildInfoRow('Birth Date', profile.birthDate.toString().split(' ')[0]),
                  _buildInfoRow('Birth Place', profile.birthPlace ?? 'N/A'),
                ],
              ),
              const SizedBox(height: 16),
              
              // Location Information Card
              _buildInfoSection(
                title: 'Location',
                children: [
                  _buildInfoRow(
                    'Coordinates',
                    '${profile.latitude?.toStringAsFixed(4) ?? 'N/A'}, ${profile.longitude?.toStringAsFixed(4) ?? 'N/A'}',
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.isFromSavedTab)
                    _buildActionButton(
                      label: 'Upload',
                      isLoading: _isUploading,
                      onPressed: _isUploading ? null : _upload,
                      icon: Icons.cloud_upload,
                    ),
                  if (!widget.isFromSavedTab)
                    _buildActionButton(
                      label: 'Save',
                      onPressed: _save,
                      icon: Icons.save,
                    ),
                  _buildActionButton(
                    label: 'Keep',
                    onPressed: _keep,
                    icon: Icons.check,
                  ),
                  _buildActionButton(
                    label: 'Delete',
                    onPressed: _delete,
                    icon: Icons.delete,
                    isDelete: true,
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required VoidCallback? onPressed,
    required IconData icon,
    bool isDelete = false,
    bool isLoading = false,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(icon, size: 18),
          label: Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isDelete ? Colors.red : Colors.blue,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          ),
        ),
      ),
    );
  }

  void _upload() async {
    // Check if device is online
    final isConnected = await _connectivityService.isConnected();
    if (!isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No internet connection. Please connect to the internet to upload.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // First check if server is reachable
      final isReachable = await _apiService.isServerReachable();
      if (!isReachable) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Offline. Please connect to internet.'),
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }

      // Upload to PostgreSQL database
      final success = await _apiService.uploadProfile(widget.profile);

      if (success) {
        // Remove from local database since uploaded
        await widget.database.residenceProfileDao.deleteProfile(widget.profile.id);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Uploaded successfully'),
            duration: Duration(seconds: 2),
          ),
        );

        // Optionally navigate back after successful upload
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.pop(context);
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upload failed: unknown error'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Upload failed: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _keep() {
    Navigator.pop(context);
  }

  void _save() async {
    await widget.database.residenceProfileDao.markAsSynced(widget.profile.id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Saved successfully to local storage'),
        duration: Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  void _showDeleteSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.delete, color: Colors.white),
            const SizedBox(width: 8),
            const Text('Resident deleted successfully!'),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 6,
      ),
    );
  }

  void _delete() async {
    await widget.database.residenceProfileDao.deleteProfile(widget.profile.id);
    _showDeleteSnackBar();
    Navigator.pop(context);
  }
}