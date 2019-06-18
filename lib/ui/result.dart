import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/bloc/bloc.dart';
import 'package:quiz_app/bloc/counters_bloc.dart';

class ResultPage extends StatefulWidget {
  // final int correctAnswers;
  final int numQuestions;

  const ResultPage({
    Key key,
    // @required this.correctAnswers,
    @required this.numQuestions,
  }) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    AppBloc _appBloc = BlocProvider.of<AppBloc>(context);
    CorrectAnswerBloc _correctAnswerBloc =
        Provider.of<CorrectAnswerBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<int>(
              initialData: 0,
              stream: _correctAnswerBloc.counter,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  Text('${snapshot.data.toString()} / ${widget.numQuestions}'),
            ),
            RaisedButton(
              child: Text('Play Again'),
              onPressed: () {
                _appBloc.dispatch(LoadCategories());
                Navigator.pop(context);
              },
            ),
          ],
        )),
      ),
    );
  }
}
