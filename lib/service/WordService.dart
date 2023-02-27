import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class IWordService {
  String baseUrl = "https://was6bk.deta.dev";

  headers() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json'
  };

  Future postTranslation(Map body);
  Future postRandomTranslation(Map body);
}

class WordService extends IWordService {

  @override
  Future postTranslation(Map body) async{

    final response = await http.post(Uri.parse("$baseUrl/api/v1/translate"), body: jsonEncode(body), headers: headers());

    switch (response.statusCode) {
      case HttpStatus.ok:

        Map<dynamic, dynamic> jsonBody = jsonDecode(utf8.decode(response.bodyBytes));
        //print(jsonBody.entries);

        return jsonBody;

      default:
        //throw NetworkError(response.statusCode.toString(), response.body);
    }
  }

  @override
  Future postRandomTranslation(Map body) async {
    final response = await http.post(Uri.parse("$baseUrl/api/v1/random"), body: jsonEncode(body), headers: headers());

    switch (response.statusCode) {
      case HttpStatus.ok:

        Map<dynamic, dynamic> jsonBody = jsonDecode(utf8.decode(response.bodyBytes));

        return jsonBody;

      default:
        //throw NetworkError(response.statusCode.toString(), response.body);
    }
  }

}