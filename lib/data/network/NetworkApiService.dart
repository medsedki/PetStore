import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'BaseApiServices.dart';
import '../app_exceptions.dart';
import '../../res/string.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getSimpleApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response = await http
          .get(
            Uri.parse(url),
          )
          .timeout(
            const Duration(seconds: 10),
          );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
        Strings.NO_INTERNET,
      );
    }

    return responseJson;
  }

  Future getApiResponse(String url, path, status) async {
    dynamic responseJson;
    var queryParameters = {
      'status': status,
    };
    final uri = Uri.http(
      url,
      path,
      queryParameters,
    );
    try {
      final response = await http
          .get(
            uri,
          )
          .timeout(
            const Duration(seconds: 10),
          );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
        Strings.NO_INTERNET,
      );
    }

    return responseJson;
  }

  @override
  Future postApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await post(
        Uri.parse(url),
        body: data,
      ).timeout(
        const Duration(seconds: 10),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
        Strings.NO_INTERNET,
      );
    }

    return responseJson;
  }

  @override
  Future editApiResponse(String url, data) async {
    dynamic responseJson;
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    try {
      Response response = await put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      ).timeout(
        const Duration(seconds: 10),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
        Strings.NO_INTERNET,
      );
    }

    return responseJson;
  }

  @override
  Future deleteApiResponse(String url, var id) async {
    dynamic responseJson;
    try {
      Response response = await delete(
        Uri.parse("$url$id"),
      ).timeout(
        const Duration(seconds: 10),
      );

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(
        Strings.NO_INTERNET,
      );
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error accured while communicating with server '
            'with status code: ${response.statusCode}');
    }
  }
}
