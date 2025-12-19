import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:file_picker/file_picker.dart';
import '../providers/contact_provider.dart';
import '../services/shared_prefs_service.dart';
import 'dart:convert';

class BackupRestoreScreen extends StatefulWidget {
  const BackupRestoreScreen({super.key});

  @override
  State<BackupRestoreScreen> createState() => _BackupRestoreScreenState();
}

class _BackupRestoreScreenState extends State<BackupRestoreScreen> {
  final bool _isCreatingBackup = false;
  final bool _isRestoring = false;
  DateTime? _lastBackupDate;
  int _totalContacts = 0;

  @override
  void initState() {
    super.initState();
    _loadBackupInfo();
  }

  Future<void> _loadBackupInfo() async {
    final lastBackup = await SharedPrefsService.getLastBackupDate();
    final provider = Provider.of<ContactProvider>(context, listen: false);
    setState(() {
      _lastBackupDate = lastBackup;
      _totalContacts = provider.allContacts.length;
    });
  }

  Future<void> _createBackup() async {
    // TODO: Implement backup functionality
    // Requires path_provider, share_plus dependencies
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Backup feature not implemented yet')),
    );
  }

  Future<void> _restoreBackup() async {
    // TODO: Implement restore functionality
    // Requires file_picker dependency
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restore feature not implemented yet')),
    );
  }

  Future<void> _showBackupInfo() async {
    final provider = Provider.of<ContactProvider>(context, listen: false);
    final jsonString = await provider.exportToJson();
    final jsonData = jsonDecode(jsonString);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Info Backup'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoItem('Total Kontak', '${jsonData['total_contacts']}'),
              _buildInfoItem('Tanggal Backup',
                  DateTime.parse(jsonData['backup_date']).toString()),
              _buildInfoItem('Format', 'JSON'),
              const SizedBox(height: 20),
              const Text(
                'Preview Data:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  jsonEncode(jsonData),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
                  maxLines: 10,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Backup & Restore'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Backup Status Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.backup, color: Colors.blue, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Status Backup',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildStatusItem(
                      'Total Kontak',
                      '$_totalContacts kontak',
                      Icons.contacts,
                    ),
                    _buildStatusItem(
                      'Backup Terakhir',
                      _lastBackupDate != null
                          ? _lastBackupDate!.toString()
                          : 'Belum pernah',
                      Icons.history,
                    ),
                    _buildStatusItem(
                      'Ukuran Data',
                      '~${(_totalContacts * 0.5).toStringAsFixed(2)} KB',
                      Icons.storage,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Backup Action
            Text(
              'Buat Backup',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.save_alt, color: Colors.green),
                      title: const Text('Buat File Backup'),
                      subtitle: const Text('Simpan semua kontak ke file JSON'),
                      trailing: _isCreatingBackup
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.chevron_right),
                      onTap: _isCreatingBackup ? null : _createBackup,
                    ),
                    ListTile(
                      leading: const Icon(Icons.info, color: Colors.blue),
                      title: const Text('Lihat Info Backup'),
                      subtitle: const Text('Detail format dan struktur data'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _showBackupInfo,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Restore Action
            Text(
              'Restore Backup',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListTile(
                  leading: const Icon(Icons.restore, color: Colors.orange),
                  title: const Text('Restore dari File'),
                  subtitle: const Text('Pulihkan kontak dari file JSON backup'),
                  trailing: _isRestoring
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.chevron_right),
                  onTap: _isRestoring ? null : _restoreBackup,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Tips
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[100]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Tips Backup',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Backup secara berkala untuk menjaga keamanan data\n'
                    '• Simpan file backup di tempat yang aman\n'
                    '• File backup berformat JSON dan dapat dibuka di text editor\n'
                    '• Restore akan mengganti semua data kontak yang ada',
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: Colors.grey[600]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
