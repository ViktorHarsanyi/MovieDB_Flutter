import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moviedb_flutter_app/model/movie_detail_req_model.dart';
import 'package:moviedb_flutter_app/model/my_favs_model.dart';
import 'package:moviedb_flutter_app/repo/home_repo.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {

  final HomeRepo _repo;
  MovieDetailCubit(this._repo) : super(MovieDetailInitial());

  Future<void> loadMovieDetail(int movieId) async{
    emit(MovieDetailLoading());
    final movie = await _repo.downloadMovieDetail(movieId);
    final isFav = await _repo.isInFavs(movieId);
    movie != null ?
    emit(MovieDetailLoaded(movie,isFav: isFav))
    : emit(MovieDetailNotFound());

  }

  Future<void> addToFavs(MovieDetailRequestModel model) async {
    emit(MovieDetailLoading());
    await _repo.saveFavToDisk(MyFavsModel(
      movieId: model.id,
      title: model.title,
      backdropPath: model.backdropPath,
      posterPath: model.posterPath
    ));
    final isFav = await _repo.isInFavs(model.id);
    emit(MovieDetailLoaded(model,isFav:isFav));
  }
}
