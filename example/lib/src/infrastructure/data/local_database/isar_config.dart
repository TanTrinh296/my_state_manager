import 'package:example/src/domain/models/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarConfig {
  static final IsarConfig _instance = IsarConfig._internal();
  factory IsarConfig() => _instance;
  IsarConfig._internal();

  late Isar _isar;

  Isar get isar => _isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    _isar = await Isar.open(
      [UserSchema], // Thêm các schema ở đây
      directory: dir.path,
    );
  }
}
