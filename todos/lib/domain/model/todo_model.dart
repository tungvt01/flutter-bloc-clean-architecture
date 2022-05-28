import 'package:objectbox/objectbox.dart';

@Entity()
class TodoModel {
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime createdDate;

  //@Property(type: PropertyType.char)
  String title;

  //@Property(type: PropertyType.char)
  String description;

  bool isFinished;

  TodoModel({
    int? id,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.isFinished,
  });
}
