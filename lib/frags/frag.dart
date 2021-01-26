import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/bloc/bloc.dart';
import 'package:moviedb_flutter_app/model/movie_model.dart';
import 'package:moviedb_flutter_app/routes/detail_route.dart';
import 'package:moviedb_flutter_app/util/consts.dart';

class HomeFrag extends StatelessWidget{
  final FragmentHierarchy type;
  const HomeFrag({this.type});
  @override
  Widget build(BuildContext context) {
   return BlocBuilder<MovieCubit, MovieState>(
      buildWhen: (_old,_new)=>_old!=_new,
     builder: (context, state) {
       return
       state is MoviesLoaded ?
        Container(
         child: GridView.count(
           crossAxisCount: 2,
           children: state.movies.map((e) => _movieItem(context, e)).toList(),
         ),
       )
           :
       Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo)));
     }
   );
  }
  Widget _movieItem(BuildContext context, Movie movie) {
    return GestureDetector(
      onTap: () {

        context.read<MovieDetailCubit>().loadMovieDetail(movie.id);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return Detail(BlocProvider.of<NavBloc>(context).state.type);
            }));
      },
      child: Card(
          elevation: 16,
          shadowColor: Theme.of(context).accentColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
         child: Container(
            decoration: BoxDecoration(image: DecorationImage(
                image: NetworkImage(imageBaseURL+movie.posterPath),
                fit: BoxFit.cover) ),
             child:
                 Align(
                     alignment: Alignment.bottomRight,
                     child: Container(
                         decoration:BoxDecoration(
                             color:Theme.of(context).primaryColor.withAlpha(187),
                             borderRadius: BorderRadius.only(topLeft:Radius.elliptical(8,8))),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text('${movie.title}',
                             maxLines: 1,
                             softWrap: true,
                             textAlign: TextAlign.end,),
                         ))),

             )
      ),
    );
  }
}