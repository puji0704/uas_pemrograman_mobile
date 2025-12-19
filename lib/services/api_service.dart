import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Map<String, dynamic>>> fetchCountries() async {
    try {
      final response = await http.get(
        Uri.parse('https://restcountries.com/v3.1/all?fields=name,idd'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Format data untuk dropdown
        final List<Map<String, dynamic>> countries = [];

        for (var country in data) {
          final name = country['name']['common']?.toString() ?? 'Unknown';
          final idd = country['idd'] ?? {};
          final root = idd['root']?.toString() ?? '';
          final suffixes = idd['suffixes']?.first?.toString() ?? '';
          final code = root + suffixes;

          if (code.isNotEmpty) {
            countries.add({
              'name': name,
              'code': code,
            });
          }
        }

        // Sort dan ambil 20 pertama
        countries.sort((a, b) => a['name'].compareTo(b['name']));
        return countries.take(20).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
