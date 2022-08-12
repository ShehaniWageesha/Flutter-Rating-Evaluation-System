import 'package:flutter/cupertino.dart';

@immutable
class RootState {
  final String error;

  RootState({
    required this.error,
  });

  RootState.init()
      : this(
          error: "",
        );

  RootState clone({
    required String error,
  }) {
    return RootState(
      error: error,
    );
  }

  static RootState get initialState => RootState(
        error: "",
      );
}
