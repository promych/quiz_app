import 'package:flutter/material.dart';
import 'package:quiz_app/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/ui/game.dart';
// import 'package:quiz_app/repositories/categories.dart';
import 'package:quiz_app/ui/home.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    _appBloc = AppBloc();
    _appBloc.dispatch(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      builder: (context) => _appBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            title: TextStyle(fontSize: 38.0, fontWeight: FontWeight.bold),
            body1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        home: Scaffold(
          body: SafeArea(
            child: BlocBuilder(
              bloc: _appBloc,
              builder: (BuildContext context, AppState state) {
                if (state is AppLoading)
                  return Center(child: CircularProgressIndicator());
                if (state is AppError)
                  return Center(child: Text('Error: ${state.message}'));
                if (state is AppLoaded)
                  return HomePage(categories: state.categories);
                if (state is QuestionsLoaded)
                  return GamePage(questions: state.questions);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _appBloc?.dispose();
    super.dispose();
  }
}
