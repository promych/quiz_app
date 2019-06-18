import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Category extends Equatable {
  final int id;
  final String name;

  Category({@required this.id, @required this.name});

  static Category fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}
