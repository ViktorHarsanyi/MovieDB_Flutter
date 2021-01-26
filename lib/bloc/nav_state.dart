part of 'nav_bloc.dart';

class NavState {
  final FragmentHierarchy type;
  const NavState({this.type = FragmentHierarchy.favs});
  const NavState.myFavs() : this(type: FragmentHierarchy.favs);
  const NavState.mostPopular() : this(type: FragmentHierarchy.popular);
  const NavState.topRated() : this(type: FragmentHierarchy.top);
}