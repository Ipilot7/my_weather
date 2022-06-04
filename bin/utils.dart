import 'package:hive/hive.dart';

mixin Utils {
  Future addBoxes<M>(String boxName, Iterable<M> value) async {
    Box<M> box = await checkOpenbox<M>(boxName);
    await box.addAll(value);
  }

  Future<Box<M>> getBoxes<M>(String boxName) async {
    Box<M> box = await checkOpenbox<M>(boxName);
    return Future<Box<M>>.value(box);
  }

  Future<Box<M>> checkOpenbox<M>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<M>(boxName);
    } else {
      return Future.value(Hive.openBox<M>(boxName));
    }
  }

  Future<bool> isEmptyBox<M>(String boxName) async {
    Box<M> box = await checkOpenbox<M>(boxName);
    return Future<bool>.value(box.isEmpty);
  }
  
}
