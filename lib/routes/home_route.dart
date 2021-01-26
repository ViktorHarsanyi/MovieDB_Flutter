import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/bloc/bloc.dart';
import 'package:moviedb_flutter_app/frags/frag.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller;
  double pagePos;
  @override
  Widget build(BuildContext context) =>

       BlocConsumer<NavBloc, NavState>(
          listener: (context, state){
           controller.jumpToPage(state.type.index);
          },
            listenWhen: (_old,_new)=>_old.type.index!=_new.type.index,
          buildWhen: (_old,_new)=>_old.type.index!=_new.type.index,
            builder:(context, state){

              return Scaffold(
                  resizeToAvoidBottomInset: true,
                  extendBodyBehindAppBar: true,
                  extendBody: true,
                  appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  title: state.type.icon(),
              ),
              body: PageView.builder(
                onPageChanged:(i) {
                  if((state.type.index - i).abs() >= 1)
                  context.read<NavBloc>().add(
                      FragmentNavigation(toFrag: FragmentHierarchy.values[i]));
                },
                controller: controller,

                itemBuilder: (context, i) {

                  if (i == pagePos.floor()) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.004)
                        ..rotateY(pagePos - i)
                        ..rotateZ(pagePos - i),
                      child: HomeFrag(type: FragmentHierarchy.values[i],)
                    );
                  } else if (i == pagePos.floor() + 1){
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.004)
                        ..rotateY(pagePos - i)
                        ..rotateZ(pagePos - i),
                      child: HomeFrag(type: FragmentHierarchy.values[i],)
                    );
                  } else {

                    return  HomeFrag(type: FragmentHierarchy.values[i],);

                  }
                },
                itemCount: FragmentHierarchy.values.length,

              ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        floatingActionButton: _navBar(context),

          );
});

  Widget _navBar(BuildContext context) =>
      Container(
        margin: EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          border:Border.all(),
          shape: BoxShape.rectangle,
          backgroundBlendMode: BlendMode.colorBurn,
          borderRadius: BorderRadius.all(Radius.circular(55)),
          color: Theme.of(context).focusColor
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(IconData(10084)),
                onPressed: ()=>
                context.read<NavBloc>().add(FragmentNavigation(toFrag:FragmentHierarchy.favs))
            ),
            IconButton(
                icon: Icon(IconData(127775)),
                onPressed: ()=>
                    context.read<NavBloc>().add(FragmentNavigation(toFrag:FragmentHierarchy.popular))
            ),
            IconButton(
                icon: Icon(IconData(128285)),
                onPressed: ()=>
                    context.read<NavBloc>().add(FragmentNavigation(toFrag:FragmentHierarchy.top))
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    controller = PageController();
      pagePos = 0.0;
      context.read<MovieCubit>().loadMovies(FragmentHierarchy.favs);
    controller.addListener(() {
      setState(() {
        pagePos = controller.page;
      });
    });
  }
}

