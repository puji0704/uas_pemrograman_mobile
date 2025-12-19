import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import '../services/shared_prefs_service.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Contact> get contacts =>
      _searchQuery.isEmpty ? _contacts : _filteredContacts;
  List<Contact> get allContacts => _contacts; // Untuk backup
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  ContactProvider() {
    loadContacts();
  }

  Future<void> loadContacts() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 500));
      final contactsData = await SharedPrefsService.getContacts();
      _contacts = contactsData;
      _filteredContacts = contactsData;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'Gagal memuat kontak';
      notifyListeners();
    }
  }

  // FITUR PENCARIAN
  void searchContacts(String query) {
    _searchQuery = query.toLowerCase().trim();

    if (_searchQuery.isEmpty) {
      _filteredContacts = _contacts;
    } else {
      _filteredContacts = _contacts.where((contact) {
        return contact.name.toLowerCase().contains(_searchQuery) ||
            contact.phone.contains(_searchQuery) ||
            contact.email.toLowerCase().contains(_searchQuery) ||
            (contact.notes != null &&
                contact.notes!.toLowerCase().contains(_searchQuery));
      }).toList();
    }

    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredContacts = _contacts;
    notifyListeners();
  }

  // FITUR BACKUP/RESTORE
  Future<String> exportToJson() async {
    try {
      final List<Map<String, dynamic>> contactsJson =
          _contacts.map((contact) => contact.toMap()).toList();

      final jsonString = '''
{
  "app_name": "SafeContect Backup",
  "backup_date": "${DateTime.now().toIso8601String()}",
  "total_contacts": ${_contacts.length},
  "contacts": $contactsJson
}
''';
      return jsonString;
    } catch (e) {
      throw Exception('Gagal membuat backup: $e');
    }
  }

  Future<void> importFromJson(String jsonString) async {
    try {
      // Parse JSON sederhana
      final contacts = await SharedPrefsService.importFromJson(jsonString);
      _contacts = contacts;
      _filteredContacts = contacts;
      await SharedPrefsService.saveContacts(_contacts);
      notifyListeners();
    } catch (e) {
      throw Exception('Gagal memulihkan backup: $e');
    }
  }

  // CRUD Operations
  Future<void> addContact(Contact contact) async {
    try {
      _contacts.add(contact);
      await SharedPrefsService.saveContacts(_contacts);
      // Update filtered contacts jika ada search query
      searchContacts(_searchQuery);
    } catch (e) {
      _error = 'Gagal menambah kontak';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateContact(String id, Contact updatedContact) async {
    try {
      final index = _contacts.indexWhere((contact) => contact.id == id);
      if (index != -1) {
        _contacts[index] = updatedContact;
        await SharedPrefsService.saveContacts(_contacts);
        searchContacts(_searchQuery);
      }
    } catch (e) {
      _error = 'Gagal mengupdate kontak';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      _contacts.removeWhere((contact) => contact.id == id);
      await SharedPrefsService.saveContacts(_contacts);
      searchContacts(_searchQuery);
    } catch (e) {
      _error = 'Gagal menghapus kontak';
      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
