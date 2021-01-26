import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moviedb_flutter_app/model/movie_detail_req_model.dart';
import 'package:moviedb_flutter_app/model/movie_model.dart';
import 'package:moviedb_flutter_app/model/movie_req_model.dart';
import 'package:moviedb_flutter_app/util/consts.dart';


class ApiClient {


  Future<List<Movie>> downloadTopRated(int page) async {
    Response response;

    try {
      response = await Dio().get(topRated + '&page=$page');
    } catch (e) {
      throw e;
    }

    return response.statusCode == 200 ? MovieRequestModel
        .fromJson(response.data)
        .results : null;
  }

  Future<List<Movie>> downloadMostPopular(int page) async {
    Response response;

    try {
      response = await Dio().get(mostPopular + '&page=$page');
    } catch (e) {
      throw e;
    }

    return response.statusCode == 200 ? MovieRequestModel
        .fromJson(response.data)
        .results : null;
  }

  Future<MovieDetailRequestModel> downloadMovie(int movieId) async {
    Response response;

    try {
      response = await Dio().get(baseURL + '/$movieId' + '?$key$config');
    } catch (e) {
      throw e;
    }

    return response.statusCode == 200 ? MovieDetailRequestModel.fromJson(
        response.data) : null;
  }
}