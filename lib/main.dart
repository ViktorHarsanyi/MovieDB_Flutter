import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:moviedb_flutter_app/bloc/bloc.dart';
import 'package:moviedb_flutter_app/model/my_favs_model.dart';
import 'package:moviedb_flutter_app/repo/home_repo.dart';
import 'package:moviedb_flutter_app/service/api_client.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'routes/routes.dart';
import 'util/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  final appDocumentDirectory =
  await path.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter<MyFavsModel>(MyFavsModelAdapter());
  final favsBox = await Hive.openBox('favs');
  init(favsBox);
  final client = ApiClient();
  final repo = HomeRepo(client: client);
  runApp(MyApp(repo: repo,));


}


class MyApp extends StatelessWidget {

final HomeRepo repo;

const MyApp({this.repo});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBloc>(
          create: (BuildContext context) => NavBloc(),
        ),
        BlocProvider<MovieCubit>(
          create: (BuildContext context) => MovieCubit(BlocProvider.of<NavBloc>(context), repo),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (BuildContext context) => MovieDetailCubit(repo),
        ),
      ],
      child: MaterialApp(
        theme:ThemeData(
            scaffoldBackgroundColor: Colors.black,
            brightness: Brightness.dark,
            primaryColor: Colors.indigo[600],
            accentColor: Colors.indigoAccent,
            focusColor: Colors.indigo[800].withOpacity(0.5),

            fontFamily: 'Georgia',

            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            )),
        home:SafeArea(
            maintainBottomViewPadding: true,
            child: Home())
      ),
    );
  }
}
