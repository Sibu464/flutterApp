import 'dart:convert';
import 'package:get_data/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class SawtoothService {
 
  

  static Future<List<Map<String, dynamic>>> fetchSawtoothWave(
      int index_) async {
    final response = await http
        .get(Uri.parse("$getPointsUrl$index_")); // Append index correctly
    if (response.statusCode == 200) {

      final data = json.decode(response.body);

      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception("Failed to load sawtooth wave data");
    }
  }
}
