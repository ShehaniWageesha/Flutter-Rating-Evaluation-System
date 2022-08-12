import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'root_event.dart';
import 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc(BuildContext context) : super(RootState.initialState);
  @override
  Stream<RootState> mapEventToState(RootEvent event) async* {
    switch (event.runtimeType) {
      case InitEvent:
        yield state.clone(error: "");
        break;
    }
  }
}
