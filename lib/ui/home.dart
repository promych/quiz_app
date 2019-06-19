import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/app/app_manager.dart';
import 'package:quiz_app/model/category.dart';

class HomePage extends StatefulWidget {
  final List<Category> categories;

  const HomePage({Key key, this.categories}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppManager>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton(
            hint: Text('Choose category'),
            value: _selectedCategoryId,
            items: widget.categories
                .map((item) => DropdownMenuItem(
                      child: Text('${item.name}'),
                      value: item.id,
                    ))
                .toList(),
            onChanged: (newValue) => setState(() {
                  _selectedCategoryId = newValue;
                }),
          ),
          RaisedButton(
            child: Text('GO'),
            onPressed: () async {
              if (_selectedCategoryId != null)
                await app.fetchQuestions(categoryId: _selectedCategoryId);
            },
          )
        ],
      ),
    );
  }
}
