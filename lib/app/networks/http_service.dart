import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:either_option/either_option.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../config/base_url_config.dart';
import '../error/exception.dart';
import '../theme/app_string.dart';

class HttpService {
  HttpService._();
  static HttpService instance = HttpService._();

  Uri getURI(String endPoint, [Map<String, dynamic>? parameters]) {
    final url = endPoint.contains(':') ? endPoint.split(':').first : endPoint;
    return Uri.https(UrlConfig.baseUrl, '${UrlConfig.subBaseUrl}$url');
  }

  //GET request
  Future<Either<CustomException, List>> getRequest(
      String endPoint,
      [Map<String, dynamic>? parameters]) async {
    log(endPoint);
    try {
      final response = await http.get(
        getURI(endPoint, parameters),
      );
      String data = utf8.decode(response.bodyBytes);
      log(jsonDecode(data).toString());
      if (response.statusCode >= 200 || response.statusCode <= 299) {
        return Right(jsonDecode(data));
      }

      return Left(CustomException(jsonDecode(data)['message'].toString()));
    } on PlatformException catch (e) {
      log(e.toString());
      return Left(
          CustomException(e.toString(), PlatformException(code: e.code)));
    } on TimeoutException catch (e) {
      log(e.toString());
      return Left(
        CustomException(AppString.timeOut, TimeoutException(e.message)),
      );
    } on SocketException catch (e) {
      log(e.toString());
      return Left(
          CustomException(AppString.timeOut, SocketException(e.message)));
    } catch (e) {
      log(e.toString());
      return Left(CustomException(e.toString(), Exception(e)));
    }
  }
}
