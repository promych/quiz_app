import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:quiz_app/model/category.dart';
import 'package:quiz_app/model/question.dart';

@immutable
abstract class AppState extends Equatable {
  AppState([List props = const []]) : super(props);
}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final List<Category> categories;

  AppLoaded({@required this.categories}) : super([categories]);
}

class AppError extends AppState {
  final String message;

  AppError({@required this.message}) : super([message]);
}

class QuestionsLoaded extends AppState {
  final List<Question> questions;

  QuestionsLoaded({@required this.questions}) : super([questions]);
}
