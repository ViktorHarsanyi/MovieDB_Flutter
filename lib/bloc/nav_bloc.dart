import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState.myFavs());

  @override
  Stream<NavState> mapEventToState(
    NavEvent event,
  ) async* {
    if(event is FragmentNavigation)
  yield* _mapFragNavToState(event);
  }

  Stream<NavState> _mapFragNavToState(NavEvent event) async*{
    if(event.toFrag == FragmentHierarchy.favs)
      yield NavState.myFavs();
    else if (event.toFrag == FragmentHierarchy.popular)
      yield NavState.mostPopular();
    else if (event.toFrag == FragmentHierarchy.top)
      yield NavState.topRated();
  }
}
enum FragmentHierarchy{
  favs,
  popular,
  top
}

extension FragProperties on FragmentHierarchy {

  static const Map<FragmentHierarchy, Widget> iconMap = {
    FragmentHierarchy.favs : Icon(IconData(10084)),
    FragmentHierarchy.top : Icon(IconData(128285)),
    FragmentHierarchy.popular : Icon(IconData(127775)),
  };

  Widget icon() {
    return 
    iconMap[this];
  }

}
