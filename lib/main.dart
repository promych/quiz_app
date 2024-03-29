import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/app/app_manager.dart';
import 'package:quiz_app/screens/game.dart';
import 'package:quiz_app/screens/home.dart';
import 'package:quiz_app/screens/result.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          title: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          body1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ChangeNotifierProvider(
              builder: (_) => AppManager.instance(),
              child: Consumer(
                builder: (BuildContext context, AppManager app, _) {
                  switch (app.status) {
                    case Status.Uninitialized:
                    case Status.AppLoading:
                      return Center(child: CircularProgressIndicator());
                    case Status.Error:
                      return Center(child: Text('Error: ${app.errorMessage}'));
                    case Status.AppLoaded:
                      return HomePage(categories: app.categoryList);
                    case Status.QuestionsLoaded:
                      return GamePage(questions: app.questionList);
                    case Status.ResultLoaded:
                      return ResultPage(
                        correctAnswers: app.correctAnswers,
                        numQuestions: app.questionList.length,
                      );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
