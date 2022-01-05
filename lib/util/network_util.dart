import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class NetworkUtil {
  factory NetworkUtil() => _instance;
  NetworkUtil.internal();

  static final NetworkUtil _instance = NetworkUtil.internal();

  final JsonDecoder _decoder = const JsonDecoder();

  String AccessToken = '';

  Future<dynamic> get(String url, {Map<String, dynamic> headers}) async {
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(url);
      print(response.statusCode);
      print(response.body);

      if (statusCode == 200 ||
          statusCode == 201 ||
          statusCode == 202 ||
          statusCode == 206 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 400) {
        return _decoder.convert(res);
      } else {
        throw Exception(res);
      }
    }).catchError((dynamic err) {
      throw Exception(err.toString());
    }); //.timeout(Duration(milliseconds: 10000));
  }

  Future<dynamic> getParam(String url,
      {Map<String, dynamic> headers,
      Map<String, String> queryParameters}) async {
    final Uri uri = Uri.http(url, '/path', queryParameters);
    return http.get(uri, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(url);
      print(response.statusCode);
      print(response.body);

      if (statusCode == 200 ||
          statusCode == 201 ||
          statusCode == 202 ||
          statusCode == 206 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 400) {
        return _decoder.convert(res);
      } else {
        throw Exception('Error while fetching data');
      }
    }).catchError((dynamic err) => throw Exception(
        'Error while fetching data')); //.timeout(Duration(milliseconds: 10000));
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic> headers, String body}) async {
    return http
        .post(Uri.parse(url), body: body, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(url);
      print(response.statusCode);
      print(response.body);

      if (statusCode == 200 ||
          statusCode == 201 ||
          statusCode == 202 ||
          statusCode == 206 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 400) {
        return _decoder.convert(res);
      } else {
        throw Exception('Error while fetching Tai');
      }
    }).catchError((dynamic err) => throw Exception(err.toString()));
  }

  Future<dynamic> postForm(String url,
      {Map<String, dynamic> headers, Map<dynamic, dynamic> body}) async {
    return http
        .post(Uri.parse(url), body: body, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(url);
      print(response.statusCode);
      print(response.body);

      if (statusCode == 200 ||
          statusCode == 201 ||
          statusCode == 202 ||
          statusCode == 206 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 400) {
        return _decoder.convert(res);
      } else {
        throw Exception('Error while fetching Tai');
      }
    }).catchError((dynamic err) => throw Exception(err.toString()));
  }

  Future<dynamic> postMultiPart(
      String url,
      String fileName,
      String fileName2,
      String fileName3,
      String token,
      String wisataId,
      String ratingPoint,
      String visitedAt,
      String review,
      String title,
      String visitedWith) async {
    final http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(url));
    request.fields['wisata_id'] = wisataId;
    request.fields['rating_point'] = ratingPoint;
    request.fields['visited_at'] = visitedAt;
    request.fields['review'] = review;
    request.fields['title'] = title;
    request.fields['visited_with'] = visitedWith;

    if (fileName != '') {
      request.files.add(await http.MultipartFile.fromPath('file[0]', fileName));
    }
    if (fileName2 != '') {
      request.files
          .add(await http.MultipartFile.fromPath('file[1]', fileName2));
    }

    if (fileName3 != '') {
      request.files
          .add(await http.MultipartFile.fromPath('file[3]', fileName3));
    }

    log('${request.files[0]}');
    log('${request.fields}');

    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    });

    final http.StreamedResponse res = await request.send();
    print(res);

    if (res.statusCode == 200 ||
        res.statusCode == 201 ||
        res.statusCode == 202 ||
        res.statusCode == 206 ||
        res.statusCode == 401 ||
        res.statusCode == 403 ||
        res.statusCode == 400) {
      final String respStr = await res.stream.bytesToString();
      // print(respStr);
      return _decoder.convert(respStr);
    } else {
      return throw Exception('Error while fetching data');
    }
  }

  Future<dynamic> put(String url,
      {Map<String, dynamic> headers, String body}) async {
    return http
        .put(Uri.parse(url), body: body, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(url);
      print(body);
      print(response.statusCode);
      print(response.body);

      if (statusCode == 200 ||
          statusCode == 201 ||
          statusCode == 202 ||
          statusCode == 206 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 400) {
        return _decoder.convert(res);
      } else {
        throw Exception('Error while fetching data');
      }
    }).catchError(
            (dynamic err) => throw Exception('Error while fetching data'));
  }

  Future<dynamic> delete(String url, {Map<String, dynamic> headers}) async {
    return http
        .delete(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      print(url);
      print(response.statusCode);
      print(response.body);

      if (statusCode == 200 ||
          statusCode == 201 ||
          statusCode == 202 ||
          statusCode == 206 ||
          statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 400) {
        return _decoder.convert(res);
      } else {
        throw Exception('Error while executing data');
      }
    }).catchError(
            (dynamic err) => throw Exception('Error while executing data'));
  }
}
