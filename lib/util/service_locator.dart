
import 'package:get_it/get_it.dart';
import 'package:moviedb_flutter_app/service/connectivity_client.dart';
import 'package:moviedb_flutter_app/service/local_db_client.dart';

final getIt = GetIt.I;

void init(final box){
  getIt.registerSingleton<LocalDB>(LocalDB(box));
  getIt.registerSingleton<ConnectivityClient>(ConnectivityClient());
}

