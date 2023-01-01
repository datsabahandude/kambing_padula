import 'package:hive/hive.dart';
part 'kambing.g.dart';
@HiveType(typeId: 0)
class Kambing extends HiveObject{
  @HiveField(0)
  late String image;
  @HiveField(1)
  late DateTime date;
  @HiveField(2)
  late String age;
  @HiveField(3)
  late String name;
  @HiveField(4)
  late String price;
  @HiveField(5)
  late String gender;
}