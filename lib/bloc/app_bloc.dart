import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:quiz_app/repositories/categories.dart';
import 'package:quiz_app/repositories/questions.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  Categories _categories;
  Questions _questions;

  // AppBloc({@required this.categories});

  @override
  AppState get initialState {
    _categories = Categories();
    _questions = Questions();
    return AppLoading();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is LoadCategories) {
      yield AppLoading();
      try {
        var categoryList = await _categories.fetchCategories();
        yield AppLoaded(categories: categoryList);
      } catch (error) {
        yield AppError(message: error.toString());
      }
    }
    if (event is LoadQuestions) {
      yield AppLoading();
      try {
        var questions =
            await _questions.fetchQuestions(categoryId: event.categoryId);
        yield QuestionsLoaded(questions: questions);
      } catch (error) {
        yield AppError(message: error.toString());
      }
    }
  }
}
