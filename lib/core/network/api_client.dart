import 'dart:convert';

import 'package:http/http.dart' as http;

/// A tiny, reusable HTTP client wrapper.
/// Keeps networking code in one place and returns decoded JSON.
class ApiClient {
  ApiClient({required this.baseUrl, http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final http.Client _httpClient;

  // Default headers for API requests
  Map<String, String> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<dynamic> get(String path, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$path');
    final mergedHeaders = {..._defaultHeaders, ...?headers};
    final response = await _httpClient.get(uri, headers: mergedHeaders);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }

    throw HttpException(
      message: 'Request failed',
      statusCode: response.statusCode,
      uri: uri,
      body: response.body,
    );
  }

  Future<dynamic> post(
      String path, {
        Map<String, String>? headers,
        Map<String, dynamic>? body,
      }) async {
    final uri = Uri.parse('$baseUrl$path');
    final mergedHeaders = {..._defaultHeaders, ...?headers};
    final response = await _httpClient.post(
      uri,
      headers: mergedHeaders,
      body: body != null ? jsonEncode(body) : null,
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    }

    throw HttpException(
      message: 'Request failed',
      statusCode: response.statusCode,
      uri: uri,
      body: response.body,
    );
  }
}

class HttpException implements Exception {
  HttpException({
    required this.message,
    required this.statusCode,
    required this.uri,
    this.body,
  });

  final String message;
  final int statusCode;
  final Uri uri;
  final String? body;

  @override
  String toString() {
    return 'HttpException(statusCode: $statusCode, uri: $uri, message: $message)';
  }
}
