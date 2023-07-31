import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/validate.dart';


part 'connecty_event.dart';
part 'connecty_state.dart';

class ConnectyBloc extends Bloc<ConnectyEvent, ConnectyState> {
  StreamController<bool> _connectyStreamsss =
      StreamController<bool>.broadcast();

  Stream<bool> get connectyStreamsssss => _connectyStreamsss.stream;

  ConnectyBloc() : super(ConnectyState(isConnectyEnable: false)) {
    on<ConnectyEvent>((event, emit) {});
  }

  Future<void> connected(BuildContext context) async {
    final connectyInitStatus = await checkInternetConnection();
    if(connectyInitStatus==false){
    showModalConnecty(context);
    }


    _connectyStreamsss.add(connectyInitStatus);
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none &&
      connectivityResult != ConnectivityResult.wifi) {
    return false; // No hay conexión a Internet
  } else {
    return true; // Hay conexión a Internet
  }
}
