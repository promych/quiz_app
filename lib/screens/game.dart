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
  var _selectedAnswer = 0;
  var _isAnswered = false;

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
              child: Column(
                children: <Widget>[
                  Text(
                    '${Uri.decodeFull(question.question)}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 40.0),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: question.answers.length,
                    itemBuilder: (context, index) {
                      var isSelectedAnswerCorrect =
                          question.answers[index] == question.correctAnswer;
                      return InkWell(
                          child: Stack(
                            children: <Widget>[
                              Text(
                                  '${Uri.decodeFull(question.answers[index])}'),
                              _isAnswered && (_selectedAnswer == index)
                                  ? Positioned(
                                      top: 0.0,
                                      right: 0.0,
                                      bottom: 0.0,
                                      child: isSelectedAnswerCorrect
                                          ? Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.highlight_off,
                                              color: Colors.red,
                                            ),
                                    )
                                  : Container(),
                            ],
                          ),
                          onTap: () {
                            if (!_isAnswered) {
                              setState(() {
                                _selectedAnswer = index;
                                _isAnswered = true;
                              });

                              if (isSelectedAnswerCorrect)
                                app.increaseCorrectAnswerCount();

                              Future.delayed(Duration(seconds: 1), () {
                                _questionBloc.nextQuestion()
                                    ? _isAnswered = false
                                    : app.showResult();
                              });
                            }
                          });
                    },
                    separatorBuilder: (context, _) => SizedBox(
                          height: 10.0,
                          child: Divider(color: Colors.grey[800]),
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              left: 0.0,
              bottom: 0.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
