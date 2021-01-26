import 'package:hive/hive.dart';
import 'package:moviedb_flutter_app/model/my_favs_model.dart';

class LocalDB<T> {
  final Box _box;

  LocalDB(this._box);

  Future<MyFavsModel> get(int movieId) async {
    if (this.boxIsClosed) return null;
    return this._box.get(movieId);
  }

  Future<bool> contains(int movieId) async {
    if (this.boxIsClosed) return false;
    return _box.containsKey(movieId);

  }

  List<T> getAll()  {
    return _box.values.toList();
  }

  Future<void> add(MyFavsModel model) async {
    if (boxIsClosed) return;

    if (!_box.containsKey(model.movieId)) {
      await _box.put(model.movieId, model);
    }else
      deleteFromLocal(model.movieId);

  }

  Future<void> deleteFromLocal(int movieId) async {
    if (boxIsClosed) return;
    await _box.delete(movieId);
  }

  bool get boxIsClosed => !(this._box?.isOpen ?? false);
}
