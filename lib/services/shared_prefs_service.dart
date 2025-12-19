import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/contact_model.dart';

class SharedPrefsService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Tema
  static Future<void> setTheme(bool isDarkMode) async {
    await _prefs?.setBool('isDarkMode', isDarkMode);
  }

  static Future<bool> getTheme() async {
    return _prefs?.getBool('isDarkMode') ?? false;
  }

  // Kontak - Simpan dan Ambil
  static Future<void> saveContacts(List<Contact> contacts) async {
    final contactsJson = contacts.map((c) => c.toMap()).toList();
    await _prefs?.setString('contacts', jsonEncode(contactsJson));
  }

  static Future<List<Contact>> getContacts() async {
    final contactsJson = _prefs?.getString('contacts');
    if (contactsJson != null) {
      try {
        final List<dynamic> data = jsonDecode(contactsJson);
        return data.map((item) => Contact.fromMap(item)).toList();
      } catch (e) {
        return [];
      }
    }
    return [];
  }

  // IMPORT dari JSON string
  static Future<List<Contact>> importFromJson(String jsonString) async {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      // Cek struktur backup
      if (jsonData['contacts'] is List) {
        final List<dynamic> contactsData = jsonData['contacts'];
        final List<Contact> contacts = contactsData
            .map((item) {
              try {
                return Contact.fromMap(item);
              } catch (e) {
                print('Error parsing contact: $e');
                return null;
              }
            })
            .where((contact) => contact != null)
            .cast<Contact>()
            .toList();

        return contacts;
      } else {
        throw Exception('Format backup tidak valid');
      }
    } catch (e) {
      throw Exception('Gagal parse JSON: $e');
    }
  }

  // Onboarding
  static Future<void> setOnboardingShown() async {
    await _prefs?.setBool('onboardingShown', true);
  }

  static Future<bool> getOnboardingShown() async {
    return _prefs?.getBool('onboardingShown') ?? false;
  }

  // Backup terakhir
  static Future<void> setLastBackupDate(DateTime date) async {
    await _prefs?.setString('lastBackupDate', date.toIso8601String());
  }

  static Future<DateTime?> getLastBackupDate() async {
    final dateString = _prefs?.getString('lastBackupDate');
    return dateString != null ? DateTime.parse(dateString) : null;
  }
}
