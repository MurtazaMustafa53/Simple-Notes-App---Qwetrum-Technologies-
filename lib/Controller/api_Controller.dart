import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:staticnotes/Model/countryModel.dart';

class ApiController {
  final String _apikey = "rc_live_390e4591c8ca43e199f5f6aa65e05de5";
  final String _cacheKey = "cached_countries_data";
  Future<List<Country>> fetchCountries() async {
    final String url = "https://api.restcountries.com/countries/v5";

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer $_apikey',
              'Content-Type': 'application/json',
            },
          )
          .timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(_cacheKey, response.body);
        final dynamic responseData = json.decode(response.body);

        // Safely extract the list where the actual country objects live
        List<dynamic> jsonList = [];

        if (responseData is Map) {
          if (responseData['data'] is List) {
            jsonList = responseData['data'];
          } else if (responseData['data'] is Map &&
              responseData['data']['objects'] is List) {
            jsonList = responseData['data']['objects'];
          } else if (responseData['data'] is Map) {
            jsonList = responseData['data'].values.toList();
          }
        } else if (responseData is List) {
          jsonList = responseData;
        }

        // Map them over to your Country model layout safely
        return jsonList
            .map((json) => Country.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print("API STATUS CODE:${response.statusCode}");
        print("Api response body:${response.body}");
        return await _getOfflineCache();
      }
    } catch (e) {
      print("ERROR:\n $e");
      throw Exception("Network error: $e");
    }
  }

  Future<List<Country>> _getOfflineCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedString = prefs.getString(_cacheKey);

    if (cachedString != null) {
      print("Found Cached data");
      final dynamic responseData = json.decode(cachedString);
      return _parseJsonList(responseData);
    } else {
      throw Exception("No internet connection and offline data saved yet");
    }
  }

  List<Country> _parseJsonList(dynamic responseData) {
    List<dynamic> jsonList = [];
    if (responseData is Map) {
      if (responseData['data'] is List) {
        jsonList = responseData['data'];
      } else if (responseData['data'] is Map &&
          responseData['data']['objects'] is List) {
        jsonList = responseData['data']['objects'];
      } else if (responseData['data'] is Map) {
        jsonList = responseData['data'].values.toList();
      }
    } else if (responseData is List) {
      jsonList = responseData;
    }

    return jsonList
        .map((json) => Country.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
