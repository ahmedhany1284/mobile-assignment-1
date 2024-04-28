import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_assignment_1/core/networking/urls.dart';
import 'package:mobile_assignment_1/core/utils/cacheHelper.dart';

class ApiService {
  // Method to perform GET request
  Future<http.Response> get({required String path, bool? addAuth, String? token}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': Urls.host,
    };
    if(addAuth == true){
      headers['Authorization'] = 'Bearer ${CacheHelper.getData(key: 'token')}';
    }
    if(token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    try {
      final response = await http.get(Uri.parse(Urls.baseUrl+path), headers: headers);
      return response;
    } catch (e) {
     rethrow ;
    }
  }

  // Method to perform POST request
  Future<http.Response> post(
      {required String path, dynamic body, bool? addAuth, String? token}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': Urls.host,
    };
    if(addAuth == true){
      headers['Authorization'] = 'Bearer ${CacheHelper.getData(key: 'token')}';
    }
    if(token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    String bodyJson = jsonEncode(body);
    try {
      final response = await http.post(Uri.parse(Urls.baseUrl+path), headers: headers, body: bodyJson);
      return response;
    } catch (e) {
      rethrow ;    }
  }

  // Method to perform PUT request
  Future<http.Response> put(
      {required String path, dynamic body, bool? addAuth, String? token}) async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Host': Urls.host,
    };
    if(addAuth == true){
      headers['Authorization'] = 'Bearer ${CacheHelper.getData(key: 'token')}';
    }
    if(token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    String bodyJson = jsonEncode(body);
    try {
      print('_--> put ${bodyJson}');

      final response = await http.put(Uri.parse(Urls.baseUrl+path), headers: headers, body: bodyJson);
      return response;
    } catch (e) {
      rethrow ;
    }
  }

}
