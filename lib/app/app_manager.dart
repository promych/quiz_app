import 'package:flutter/material.dart';
import 'package:quiz_app/model/category.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/repositories/categories.dart';
import 'package:quiz_app/repositories/questions.dart';

enum Status {
  Uninitialized,
  AppLoading,
  Error,
  AppLoaded,
  QuestionsLoaded,
  ResultLoaded
}

class AppManager extends ChangeNotifier {
  Categories _categories;
  Questions _questions;
  List<Category> _categoryList;
  List<Question> _questionList;
  int _correctAnswers = 0;

  Status _status = Status.Uninitialized;
  String _errorMessage = '';

  AppManager.instance()
      : _categories = Categories(),
        _questions = Questions() {
    fetchCategories();
  }

  Status get status => _status;
  String get errorMessage => _errorMessage;
  List<Category> get categoryList => _categoryList;
  List<Question> get questionList => _questionList;
  int get correctAnswers => _correctAnswers;

  Future<void> fetchCategories() async {
    try {
      _status = Status.AppLoading;
      notifyListeners();
      _categoryList = _categoryList ?? await _categories.fetchCategories();
      _status = Status.AppLoaded;
      notifyListeners();
    } catch (error) {
      _errorMessage = error;
      _status = Status.Error;
      notifyListeners();
    }
  }

  Future<void> fetchQuestions({@required int categoryId}) async {
    try {
      _status = Status.AppLoading;
      notifyListeners();
      _questionList = await _questions.fetchQuestions(categoryId: categoryId);
      _status = Status.QuestionsLoaded;
      _correctAnswers = 0;
      notifyListeners();
    } catch (error) {
      _errorMessage = error;
      _status = Status.Error;
      notifyListeners();
    }
  }

  showResult() {
    _status = Status.ResultLoaded;
    notifyListeners();
  }

  increaseCorrectAnswerCount() {
    _correctAnswers++;
  }
}
