import 'package:hive/hive.dart';

part 'my_favs_model.g.dart';

@HiveType(typeId: 0)
class MyFavsModel extends HiveObject{
  @HiveField(0)
  final int movieId;

  @HiveField(1)
  final String backdropPath;

  @HiveField(2)
  final String posterPath;

  @HiveField(3)
  final String title;


  MyFavsModel(
      {this.movieId,
        this.backdropPath,
        this.posterPath,
        this.title,
       });
}