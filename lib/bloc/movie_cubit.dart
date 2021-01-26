import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:moviedb_flutter_app/model/movie_model.dart';
import 'package:moviedb_flutter_app/repo/home_repo.dart';
import 'package:moviedb_flutter_app/service/connectivity_client.dart';
import 'package:moviedb_flutter_app/util/service_locator.dart';

import 'nav_bloc.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final NavBloc navBloc;
  StreamSubscription navSubscription;
  final HomeRepo repo;
  final bool testing;

  MovieCubit(this.navBloc, this.repo, {this.testing = false}) : super(MovieInitial()){
   navSubscription = navBloc.listen((state) {
     loadMovies(state.type);
   });

   if(!testing)
   getIt<ConnectivityClient>().connectionChange.listen((event) {
     print('connection $event');
     if(event)
     loadMovies(navBloc.state.type);
     else
       navBloc.state.type == FragmentHierarchy.favs ?
       loadMovies(FragmentHierarchy.favs)
     : emit(MovieNotFound());
   });
  }

  Future<void> loadMovies(FragmentHierarchy type) async{
    emit(MovieLoading());
    List<Movie> movies;
    if(type == FragmentHierarchy.top)
     movies = await repo.downloadTopRated(1);
    else if (type == FragmentHierarchy.popular)
     movies = await repo.downloadMostPopular(1);
    else if(type == FragmentHierarchy.favs){
      final favs = repo.loadFavsFromDisk();
         movies = favs.map((e) =>
              Movie(posterPath: e.posterPath, id: e.movieId, title: e.title))
          .toList();

    }
    print('${type.index}${movies!=null}');
    movies != null ?
    emit(MoviesLoaded(movies: movies,type: type ))
    : emit(MovieNotFound());
  }

  @override
  Future<void> close() {
    navSubscription.cancel();
    if(!testing)
    getIt<ConnectivityClient>().dispose();
    return super.close();
  }
}
