import 'dart:io';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityClient {

  bool isConnected = false;
  PublishSubject connectivitySubject =
  PublishSubject<bool>();

  ConnectivityClient(){
    final Connectivity _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen(onChanged);
    verifyConnectivity();
  }

  Stream get connectionChange => connectivitySubject.stream;

  void dispose() {
    connectivitySubject.close();
  }

  void onChanged(ConnectivityResult result) {
    verifyConnectivity();
  }

  Future<bool> verifyConnectivity() async {
    bool wConnected = isConnected;

    try {
      final result = await InternetAddress.lookup('themoviedb.org');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }

    if (wConnected != isConnected) {
      connectivitySubject.add(isConnected);
    }
    return isConnected;
  }
}
