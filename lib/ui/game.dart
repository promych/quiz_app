import 'package:flutter/material.dart';
import 'package:quiz_app/app/app_manager.dart';
import 'package:quiz_app/app/question_bloc.dart';
import 'package:quiz_app/model/question.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  final List<Question> questions;

  const GamePage({Key key, @required this.questions}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  QuestionBloc _questionBloc;

  @override
  void initState() {
    super.initState();
    _questionBloc = QuestionBloc(widget.questions.length);
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppManager>(context);

    return StreamBuilder<int>(
      initialData: 0,
      stream: _questionBloc.counter,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Question question = widget.questions[snapshot.data];

        return Stack(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '${Uri.decodeFull(question.question)}',
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 40.0),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: question.answers.length,
                      itemBuilder: (BuildContext context, int index) {
                        var _isSelectedAnswerCorrect =
                            question.answers[index] == question.correctAnswer;
                        return InkWell(
                            child: Text(
                                '${Uri.decodeFull(question.answers[index])}'),
                            splashColor: _isSelectedAnswerCorrect
                                ? Colors.green
                                : Colors.red,
                            onTap: () {
                              if (_isSelectedAnswerCorrect)
                                app.increaseCorrectAnswerCount();

                              if (!_questionBloc.nextQuestion())
                                app.showResult();
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: Column(children: [
                Text(
                    'Question: ${(snapshot.data + 1).toString()} / ${widget.questions.length}'),
                Text('Correct: ${app.correctAnswers}')
              ]),
            )
          ],
        );
      },
    );
  }
}
