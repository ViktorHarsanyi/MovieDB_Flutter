part of 'movie_cubit.dart';

@immutable
abstract class MovieState extends Equatable{
  final FragmentHierarchy type;
  const MovieState({this.type});
  @override
  List<Object> get props => const [];
}
class MovieInitial extends MovieState{
  const MovieInitial();
}

class MovieLoading extends MovieState {
  const MovieLoading();
}

class MovieNotFound extends MovieState {
  const MovieNotFound();
}
class MoviesLoaded extends MovieState {
  final List<Movie> movies;
  final type;
  final isFav;

  const MoviesLoaded({@required this.movies,@required this.type, this.isFav = false});

  @override
  List<Object> get props => [movies,type,isFav];
}


