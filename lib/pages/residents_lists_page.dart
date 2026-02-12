import 'package:flutter/material.dart';
import '../database/database.dart';
import '../services/api_service.dart';
import '../services/connectivity_service.dart';
import 'resident_details_page.dart';
import '../widgets/residence_profiling_form.dart';

class ResidentsListsPage extends StatefulWidget {
  const ResidentsListsPage({super.key});

  @override
  State<ResidentsListsPage> createState() => _ResidentsListsPageState();
}

class _ResidentsListsPageState extends State<ResidentsListsPage> {
  final AppDatabase _database = AppDatabase();
  final ApiService _apiService = ApiService();
  final ConnectivityService _connectivityService = ConnectivityService();
  
  // Selection state for batch operations
  bool _isSelectionMode = false;
  final Set<int> _selectedIds = {};
  bool _isUploading = false;
  bool _isDeleting = false;

  @override
  void dispose() {
    _database.close();
    super.dispose();
  }

  void _clearSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedIds.clear();
    });
  }

  Future<void> _uploadSelected() async {
    if (_selectedIds.isEmpty) return;

    setState(() => _isUploading = true);

    try {
      // Check internet connection
      final isConnected = await _connectivityService.isConnected();
      if (!isConnected) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No internet connection. Cannot upload.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        return;
      }

      // Get all selected profiles
      final allProfiles = await _database.residenceProfileDao.getAllProfiles();
      final selectedProfiles = allProfiles.where((p) => _selectedIds.contains(p.id)).toList();

      // Upload each selected profile
      int successCount = 0;
      for (final profile in selectedProfiles) {
        try {
          final success = await _apiService.uploadProfile(profile);
          if (success) {
            await _database.residenceProfileDao.deleteProfile(profile.id);
            successCount++;
          }
        } catch (e) {
          // Continue with next profile on error
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Uploaded $successCount/${_selectedIds.length} residents successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
        _clearSelection();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
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

  Future<void> _deleteSelected() async {
    if (_selectedIds.isEmpty) return;

    // Show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Residents'),
        content: Text('Are you sure you want to delete ${_selectedIds.length} resident(s)? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isDeleting = true);

    try {
      for (final id in _selectedIds) {
        await _database.residenceProfileDao.deleteProfile(id);
      }

      if (mounted) {
        _showDeleteSnackBar();
        _clearSelection();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Delete failed: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: _isSelectionMode
              ? Text('${_selectedIds.length} selected')
              : const Text('Residents Lists'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Saved'),
              Tab(text: 'Drafts'),
            ],
          ),
          actions: _isSelectionMode
              ? [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _clearSelection,
                  ),
                ]
              : [],
        ),
        body: TabBarView(
          children: [
            _buildProfilesList(_database.residenceProfileDao.watchSyncedProfiles(), true),
            _buildProfilesList(_database.residenceProfileDao.watchUnsyncedProfiles(), false),
          ],
        ),
        bottomNavigationBar: _isSelectionMode
            ? Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    // Delete button (always available)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isDeleting ? null : _deleteSelected,
                        icon: _isDeleting
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.delete),
                        label: const Text('Delete'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Upload button (only for Saved tab)
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          final isSavedTab = DefaultTabController.of(context).index == 0;
                          return ElevatedButton.icon(
                            onPressed: (isSavedTab && !_isUploading) ? _uploadSelected : null,
                            icon: _isUploading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.cloud_upload),
                            label: const Text('Upload'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildProfilesList(Stream<List<ResidenceProfile>> profilesStream, bool isFromSaved) {
    return StreamBuilder<List<ResidenceProfile>>(
      stream: profilesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No records found.'));
        } else {
          // Copy and sort profiles so newest entries appear first (createdAt desc)
          final profiles = List<ResidenceProfile>.from(snapshot.data!);
          profiles.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              final isSelected = _selectedIds.contains(profile.id);
              final fullName = '${profile.firstName} ${profile.middleName ?? ''} ${profile.lastName}'.trim();
              
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: isSelected ? Colors.blue[50] : null,
                child: InkWell(
                  onLongPress: isFromSaved
                      ? () {
                          setState(() {
                            _isSelectionMode = true;
                            if (_selectedIds.contains(profile.id)) {
                              _selectedIds.remove(profile.id);
                            } else {
                              _selectedIds.add(profile.id);
                            }
                          });
                        }
                      : null,
                  onTap: _isSelectionMode
                      ? () {
                          setState(() {
                            if (_selectedIds.contains(profile.id)) {
                              _selectedIds.remove(profile.id);
                              if (_selectedIds.isEmpty) {
                                _isSelectionMode = false;
                              }
                            } else {
                              _selectedIds.add(profile.id);
                            }
                          });
                        }
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResidentDetailsPage(
                                profile: profile,
                                database: _database,
                                isFromSavedTab: isFromSaved,
                              ),
                            ),
                          );
                        },
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Selection Checkbox (only in selection mode and Saved tab)
                        if (_isSelectionMode && isFromSaved)
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Checkbox(
                              value: isSelected,
                              onChanged: (value) {
                                setState(() {
                                  if (value == true) {
                                    _selectedIds.add(profile.id);
                                  } else {
                                    _selectedIds.remove(profile.id);
                                    if (_selectedIds.isEmpty) {
                                      _isSelectionMode = false;
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        // Profile Image
                        profile.photoPath != null
                            ? CircleAvatar(
                                radius: 32,
                                backgroundImage: AssetImage(profile.photoPath!),
                              )
                            : CircleAvatar(
                                radius: 32,
                                child: Icon(
                                  Icons.person,
                                  size: 28,
                                ),
                              ),
                        const SizedBox(width: 16),
                        // Profile Information
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fullName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Status: ${profile.maritalStatus}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Date: ${profile.createdAt.toString().split(' ')[0]}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Edit Button (hidden in selection mode)
                        if (!_isSelectionMode)
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ResidenceProfilingForm(
                                    profileToEdit: profile,
                                    database: _database,
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
