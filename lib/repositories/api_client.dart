import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/model/category.dart';
import 'package:quiz_app/model/question.dart';

class ApiClient {
  static const String _baseUrl = 'https://opentdb.com/';

  Future<List<Category>> getAllCategories() async {
    const String url = _baseUrl + 'api_category.php';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      Iterable data = List.from(body['trivia_categories']);
      List<Category> cat = data.map((json) => Category.fromJson(json)).toList();
      return cat;
    } else {
      return throw Exception('error fetching categories');
    }
  }

  Future<List<Question>> getQuestions(int categoryId,
      [int maxQuestions = 3]) async {
    String url = _baseUrl +
        '/api.php?category=$categoryId&amount=$maxQuestions&encode=url3986';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      Iterable data = List.from(body['results']);
      List<Question> questions =
          data.map((json) => Question.fromJson(json)).toList();
      return questions;
    } else {
      return throw Exception('error fetching questions');
    }
  }
}
