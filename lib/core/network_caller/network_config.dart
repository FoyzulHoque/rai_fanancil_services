// lib/core/network_caller/network_config.dart
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import '../../features/auth/signin/screens/signin_screens.dart';
import '../services_class/shared_preferences_helper.dart';

class NetworkResponse {
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final String? errorMessage;
  final bool isSuccess;

  NetworkResponse({
    required this.statusCode,
    this.responseData,
    this.errorMessage = "Request failed !",
    required this.isSuccess,
  });
}

class NetworkCall {
  static final Logger _logger = Logger();

  /*static Future<String?> _getAuthHeader() async {
    final token = await SharedPreferencesHelper.getAccessToken();
    if (token != null && token.isNotEmpty) {
      return token;
    }
    return null;
  }*/
  static Future<String?> _getAuthHeader() async {
    final token = await SharedPreferencesHelper.getAccessToken();

    print("=== TOKEN CHECK ===");
    print("Raw token from SharedPrefs: '$token'");
    print("Token null? ${token == null}");
    print("Token empty? ${token?.isEmpty}");
    print("====================");

    if (token != null && token.trim().isNotEmpty) {
      return token.trim();
    }
    return null;
  }

  static Future<void> _logOut() async {
    await SharedPreferencesHelper.clearAccessToken();
    Get.offAll(() =>  LoginScreen());
  }

  /// GET request
  static Future<NetworkResponse> getRequest({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      String fullUrl = url;
      if (queryParams != null && queryParams.isNotEmpty) {
        fullUrl += '?';
        queryParams.forEach((key, value) {
          fullUrl += '$key=${Uri.encodeComponent(value.toString())}&';
        });
        fullUrl = fullUrl.substring(0, fullUrl.length - 1);
      }

      final Uri uri = Uri.parse(fullUrl);
      final Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final authHeader = await _getAuthHeader();
      if (authHeader != null) {
        headers['Authorization'] = authHeader;
      }

      _logRequest(fullUrl, headers);
      final Response response = await get(uri, headers: headers);
      _logResponse(fullUrl, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: 401, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  /// POST request
  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final authHeader = await _getAuthHeader();
      if (authHeader != null) {
        headers['Authorization'] = authHeader;
      }

      _logRequest(url, headers, requestBody: body);
      final Response response = await post(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: 401, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  /// PATCH request
  static Future<NetworkResponse> patchRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final authHeader = await _getAuthHeader();
      if (authHeader != null) {
        headers['Authorization'] = authHeader;
      }

      _logRequest(url, headers, requestBody: body);
      final Response response = await patch(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: 401, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  /// PUT request
  static Future<NetworkResponse> putRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final authHeader = await _getAuthHeader();
      if (authHeader != null) {
        headers['Authorization'] = authHeader;
      }

      _logRequest(url, headers, requestBody: body);
      final Response response = await put(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: 401, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  /// DELETE request
  /*
  static Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final authHeader = await _getAuthHeader();
      if (authHeader != null) {
        headers['Authorization'] = authHeader;
      }
      _logRequest(url, headers, requestBody: body);
      final Response response = await delete(
        uri,
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
       // await _logOut();
        return NetworkResponse(statusCode: 401, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }*/

  /// POST request
  static Future<NetworkResponse> deleteRequest({
    required String url,
  }) async {
    try {
      final Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final authHeader = await _getAuthHeader();
      if (authHeader != null) {
        headers['Authorization'] = authHeader;
      }

      _logRequest(url, headers, );
      final Response response = await delete(
        uri,
        headers: headers,
      );
      _logResponse(url, response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        return NetworkResponse(statusCode: 401, isSuccess: false);
      } else {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: jsonDecode(response.body),
          errorMessage: response.body,
        );
      }
    } catch (e) {
      return NetworkResponse(statusCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  /// Universal Multipart Request
  static Future<NetworkResponse> multipartRequest({
    required String url,
    Map<String, String>? fields,
    File? imageFile,
    String methodType = 'POST', // Can be 'POST', 'PUT', 'PATCH'
    String imageFieldName = 'image',
    bool sendAuthHeader = true,
  }) async {
    try {
      final request = http.MultipartRequest(methodType, Uri.parse(url));

      // Add headers
      request.headers['Accept'] = 'application/json';
      if (sendAuthHeader) {
        final authToken = await _getAuthHeader();
        if (authToken != null && authToken.trim().isNotEmpty) {
          request.headers['Authorization'] = authToken.trim();
        }
      }

      // Add fields
      if (fields != null && fields.isNotEmpty) {
        request.fields.addAll(fields);
      }

      // Add image file
      if (imageFile != null) {
        final String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
        request.files.add(
          await http.MultipartFile.fromPath(
            imageFieldName,
            imageFile.path,
            contentType: MediaType.parse(mimeType),
          ),
        );
      }

      _logRequest(url, request.headers, requestBody: fields);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      _logResponse(url, response);

      dynamic responseData;
      try {
        if (response.body.isNotEmpty) {
          responseData = jsonDecode(response.body);
        }
      } catch (e) {
        _logger.w('Failed to decode JSON from response body: ${response.body}');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: responseData,
        );
      } else if (response.statusCode == 401) {
        await _logOut();
        String errorMessage = 'Unauthorized. Please log in again.';
        if (responseData != null && responseData is Map<String, dynamic> && responseData['message'] != null) {
            errorMessage = responseData['message'];
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errorMessage: errorMessage,
        );
      } else {
        String errorMessage = 'An unknown error occurred.';
        if (responseData != null && responseData is Map<String, dynamic> && responseData['message'] != null) {
          errorMessage = responseData['message'];
        } else if (response.body.isNotEmpty) {
          errorMessage = response.body;
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          responseData: responseData,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      _logger.e("Multipart Request Failed: $e");
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Logging
  static void _logRequest(String url, Map<String, dynamic> headers, {Map<String, dynamic>? requestBody}) {
    _logger.i("REQUEST\nURL: $url\nHeaders: $headers\nBody: ${jsonEncode(requestBody)}");
  }

  static void _logResponse(String url, Response response) {
    _logger.i("RESPONSE\nURL: $url\nStatus: ${response.statusCode}\nBody: ${response.body}");
  }
}
