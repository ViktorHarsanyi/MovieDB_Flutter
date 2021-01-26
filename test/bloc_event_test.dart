import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb_flutter_app/bloc/bloc.dart';

void main() {

  group('Fragmentnavigation Event', () {
    group('Fragment type', () {
      test('supports value comparisons', () {
        expect(FragmentNavigation(toFrag: FragmentHierarchy.popular),FragmentNavigation(toFrag: FragmentHierarchy.popular));
      });
    });
  });
}