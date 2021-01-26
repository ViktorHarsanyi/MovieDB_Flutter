part of 'movie_detail_cubit.dart';

@immutable
abstract class MovieDetailState {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  const MovieDetailInitial();
}

class MovieDetailLoading extends MovieDetailState{
  const MovieDetailLoading();
}

class MovieDetailLoaded extends MovieDetailState{
  final isFav;
  final MovieDetailRequestModel movie;
  const MovieDetailLoaded(this.movie, {this.isFav = false});
}

class MovieDetailNotFound extends MovieDetailState {
  const MovieDetailNotFound();
}