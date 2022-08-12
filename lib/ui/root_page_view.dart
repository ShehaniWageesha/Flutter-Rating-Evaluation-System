import 'package:crud_sliit/ui/login_page_view.dart';
import 'package:crud_sliit/ui/user_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/root_page/root_bloc.dart';
import '../db/api/auth.dart';
import 'theme/styled_colors.dart';

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late RootBloc rootBloc;
  bool isLoading = true;

  void checkLogin() async {
    setState(() {
      isLoading = true;
    });
    final User? user = await Auth().getLoggedUser();
    final String role = await Auth().getUserRole(user?.email);
  }

  @override
  void initState() {
    rootBloc = BlocProvider.of<RootBloc>(context);
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Container()
        : Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(
                  height: 25.0,
                ),
                CircularProgressIndicator(
                  color: StyledColor.blurPrimary,
                ),
              ],
            ),
          );
  }
}
