import 'dart:io';

import 'package:cise/model/RandomTranslateModel.dart';
import 'package:cise/model/RandomTranslateResponseModel.dart';
import 'package:cise/model/translateModel.dart';
import 'package:cise/model/translateResponseModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class IWordService {
  String baseUrl = "https://was6bk.deta.dev";

  headers() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  Future postTranslation(TranslateModel model);
  Future postRandomTranslation(RandomTranslateModel model);
}

class WordService extends IWordService {

  @override
  Future postTranslation(TranslateModel model) async{

    final response = await http.post(Uri.parse("$baseUrl/api/v1/translate"), body: jsonEncode(model), headers: headers());

    switch (response.statusCode) {
      case HttpStatus.ok:

        return TranslateResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      default:
        //throw NetworkError(response.statusCode.toString(), response.body);
    }
  }

  @override
  Future postRandomTranslation(RandomTranslateModel model) async {
    final response = await http.post(Uri.parse("$baseUrl/api/v1/random"), body: jsonEncode(model), headers: headers());

    switch (response.statusCode) {
      case HttpStatus.ok:

        return RandomTranslateResponseModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

      default:
        //throw NetworkError(response.statusCode.toString(), response.body);
    }
  }

}