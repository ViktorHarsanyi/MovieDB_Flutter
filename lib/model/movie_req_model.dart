

import 'movie_model.dart';

class MovieRequestModel {
  int page;
  int totalResults;
  int totalPages;
  List<Movie> results;

  MovieRequestModel(
      {this.page, this.totalResults, this.totalPages, this.results});

  MovieRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalResults = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      results = List<Movie>();
      json['results'].forEach((movie) {
        results.add(Movie.fromJson(movie));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalResults;
    data['total_pages'] = this.totalPages;
    if (this.results != null) {
      data['results'] = this.results.map((movie) => movie.toJson()).toList();
    }
    return data;
  }
}
