import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Question extends Equatable {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question({this.question, this.answers, this.correctAnswer});

  static Question fromJson(Map<String, dynamic> json) {
    var correctAnswer = json['correct_answer'];
    var incorrectAnswers = json['incorrect_answers'];
    return Question(
      question: json['question'],
      correctAnswer: correctAnswer,
      answers: List.from(incorrectAnswers)..add(correctAnswer),
    );
  }
}
