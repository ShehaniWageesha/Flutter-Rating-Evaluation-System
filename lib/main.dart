import 'package:crud_sliit/bloc/root_page/root_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/root_page/root_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      title: 'NaviClear',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RootProvider(),
    );

    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<RootBloc>(create: (context) => RootBloc(context)),
      ],
      child: materialApp,
    );
  }
}
