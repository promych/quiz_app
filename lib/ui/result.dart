import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/app/app_manager.dart';

class ResultPage extends StatefulWidget {
  final int correctAnswers;
  final int numQuestions;

  const ResultPage({
    Key key,
    @required this.correctAnswers,
    @required this.numQuestions,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppManager>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${app.correctAnswers} / ${widget.numQuestions}'),
              RaisedButton(
                child: Text('Play Again'),
                onPressed: () async {
                  await app.fetchCategories();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
