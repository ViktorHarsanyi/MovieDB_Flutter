import 'package:flutter/material.dart';
import 'package:moviedb_flutter_app/model/movie_detail_req_model.dart';
import 'package:moviedb_flutter_app/model/movie_model.dart';
import 'package:moviedb_flutter_app/model/my_favs_model.dart';
import 'package:moviedb_flutter_app/service/api_client.dart';
import 'package:moviedb_flutter_app/service/local_db_client.dart';
import 'package:moviedb_flutter_app/util/service_locator.dart';

class HomeRepo {
  final ApiClient client;

  HomeRepo({@required this.client})
      : assert(client != null);


  Future<List<Movie>> downloadTopRated(int page) async {
    return await client.downloadTopRated(page);
  }

  Future<List<Movie>> downloadMostPopular(int page) async {
    return await client.downloadMostPopular(page);
  }

  Future<MovieDetailRequestModel> downloadMovieDetail(int movieId) async {
    return await client.downloadMovie(movieId);
  }

 List<MyFavsModel> loadFavsFromDisk() {
    return getIt<LocalDB>().getAll().cast();
  }

  Future<bool> isInFavs(int movieId) async {
    return await getIt<LocalDB>().contains(movieId);
  }

  Future<void> saveFavToDisk(MyFavsModel model) async {
    await getIt<LocalDB>().add(model);
  }
}
