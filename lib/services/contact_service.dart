// lib/services/contact_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/constants.dart';

class ContactService {
  static Future<bool> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(AppConstants.formSubmitEndpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'message': message,
          '_subject': 'New Portfolio Contact from $name',
          '_captcha': 'false',
          '_template': 'table',
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
