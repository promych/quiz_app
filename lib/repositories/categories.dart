import 'package:quiz_app/model/category.dart';

import 'api_client.dart';

class Categories {
  final _apiClient = ApiClient();

  Future<List<Category>> fetchCategories() async {
    return await _apiClient.getAllCategories();
  }
}
