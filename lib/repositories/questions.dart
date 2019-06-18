import 'package:meta/meta.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/repositories/api_client.dart';

class Questions {
  ApiClient _apiClient = ApiClient();

  Future<List<Question>> fetchQuestions({@required int categoryId}) async =>
      await _apiClient.getQuestions(categoryId);
}
