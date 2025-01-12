import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:5050/api";

  Future<List<Map<String, dynamic>>> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/userdata'),
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<Map<String, dynamic>> addUser(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/useradd'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData),
      );

      debugPrint('${response.statusCode}');
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to add data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding data: $e');
    }
  }

  Future<Map<String, dynamic>> deleteData() async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/userdata'),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to delete data: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error deleting data: $e');
    }
  }
}
