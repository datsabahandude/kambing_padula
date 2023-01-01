import 'package:hive/hive.dart';
import 'kambing.dart';

class Boxes {
  static Box<Kambing> getKambings() =>
      Hive.box<Kambing>('kambings');
}