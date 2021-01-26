import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/bloc/bloc.dart';
import 'package:moviedb_flutter_app/util/consts.dart';

class Detail extends StatelessWidget {

  final FragmentHierarchy type;
  const Detail(this.type);
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child:BlocBuilder<MovieDetailCubit,MovieDetailState>(

        builder:(context, state) {
          return Scaffold(
            extendBody: true,
        extendBodyBehindAppBar: true,

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      body: state is MovieDetailLoaded ?
             Stack(
            children: [
              FadeInImage(
                  placeholder:AssetImage('assets/csapo.png'),
                  image: NetworkImage(posterImageBaseURL+'/${state.movie.posterPath}')
              ),

              DraggableScrollableSheet(
                initialChildSize: 0.32,
                minChildSize: 0.32,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(gradient:LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                    colors: [
                      Colors.black,
                      Colors.black87
                    ])
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
              ListTile(
                  leading: ClipOval(
                      child:FadeInImage(
                      placeholder:AssetImage('assets/csapo.png'),
                      image: NetworkImage(posterImageBaseURL+'/${state.movie.backdropPath}')
                      )
                  ),
                  title: Text(state.movie.title),
                  subtitle: Text(state.movie.tagline),
              ),
                    ListTile(title: Center(child: Text(state.movie.genres.map((e) => e.name).toString()))),
              ListTile(title:RichText(
                  text: TextSpan(
                    text: state.movie.overview
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 10,
                )
              )
            ]
                ),
              );
            },
            ),
            ]
          )
          : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),)),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              floatingActionButton: IconButton(
                icon: state is MovieDetailLoaded ?
                  state.isFav ?
              Icon(
                  IconData(10084),color: Colors.red,)
                  : Icon(IconData(9825),color:Colors.red)
                    : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo)),
                iconSize: 80,
                onPressed: state is MovieDetailLoaded ?
                    () {
                      context.read<MovieDetailCubit>().addToFavs(state.movie);
                      context.read<MovieCubit>().loadMovies(type);
                    }: null,),

      );

      })
    );
  }

}
