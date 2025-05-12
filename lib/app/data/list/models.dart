import 'package:hive/hive.dart';

part 'models.g.dart';

@HiveType(typeId: 0)
class CustomList extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<Item> items;

  CustomList({required this.name, required this.items});
}

@HiveType(typeId: 1)
class Item extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String type; // 'book' or 'movie'

  Item({required this.title, required this.type});
}
