import 'dart:async';

class QuestionBloc {
  final int questionMax;
  QuestionBloc(this.questionMax);

  int _currentQuestionCounter = 0;

  var _controller = StreamController<int>();

  Stream<int> get counter => _controller.stream;

  bool nextQuestion() {
    if (_currentQuestionCounter + 1 < questionMax) {
      _currentQuestionCounter++;
      _controller.add(_currentQuestionCounter);
      return true;
    } else {
      return false;
    }
  }
}
