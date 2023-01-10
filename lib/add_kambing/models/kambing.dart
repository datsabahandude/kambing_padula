import 'dart:typed_data';
import 'package:hive/hive.dart';
part 'kambing.g.dart';
@HiveType(typeId: 0)
class Kambing extends HiveObject{
  @HiveField(0)
  late Uint8List imageBytes;
  @HiveField(1)
  late DateTime date;
  @HiveField(2)
  late String name;
  @HiveField(3)
  late String price;
  @HiveField(4)
  late String gender;
}