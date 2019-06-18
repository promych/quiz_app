import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AppEvent extends Equatable {
  AppEvent([List props = const []]) : super(props);
}

class LoadCategories extends AppEvent {}

class LoadQuestions extends AppEvent {
  final int categoryId;

  LoadQuestions({@required this.categoryId}) : super([categoryId]);
}
