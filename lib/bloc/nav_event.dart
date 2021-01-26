part of 'nav_bloc.dart';

abstract class NavEvent extends Equatable {
  final FragmentHierarchy toFrag;
  const NavEvent({this.toFrag = FragmentHierarchy.favs});

}

class FragmentNavigation extends NavEvent{

  final FragmentHierarchy toFrag;
  const FragmentNavigation({this.toFrag});
  @override
  List<Object> get props => [toFrag];

}
