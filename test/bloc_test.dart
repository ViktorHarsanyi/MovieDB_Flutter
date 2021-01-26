import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:mockito/mockito.dart';
import 'package:moviedb_flutter_app/bloc/bloc.dart';
import 'package:moviedb_flutter_app/model/movie_model.dart';
import 'package:moviedb_flutter_app/repo/home_repo.dart';
import 'package:moviedb_flutter_app/service/connectivity_client.dart';
import 'package:moviedb_flutter_app/util/service_locator.dart';

class MRepo extends Mock implements HomeRepo {}

void main() {
  MovieCubit movieCubit;
  NavBloc navBloc;
  MRepo mRepo;
  List<Movie> mMovies;

  setUp(() async {
    mMovies = [Movie(title:'xxx',id:123)];
    mRepo = MRepo();
    navBloc = NavBloc();
    movieCubit = MovieCubit(navBloc,mRepo, testing: true);
  });

  tearDown(() {
    movieCubit?.close();
    navBloc?.close();
  });

  test('init', () {
    expect(movieCubit.state, MovieInitial());
  });

  test('close does not hinder state', () {
    expectLater(
      movieCubit,
      emitsInOrder([emitsDone]),
    );
    movieCubit.close();
  });

  group('loadMovies', () {
    test(
        'movieCubit.loadMovies called by NavBloc stream, load emits correct fragment type',
            () {

          when(mRepo.downloadMostPopular(1))
              .thenAnswer((_) => Future.value(mMovies));
         navBloc.add(FragmentNavigation(toFrag: FragmentHierarchy.popular));

          final testRes = [
            MovieLoading(),
            MoviesLoaded(movies: mMovies, type: FragmentHierarchy.popular)
          ];
          expectLater(
            movieCubit,
            emitsInOrder(testRes),
          );
        });



  });
}
