import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/data/loginRepo.dart';
import 'package:login/logic/SignInBloc.dart';
import 'package:login/persentation/home.dart';
import 'package:login/persentation/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>(
      lazy: true,
      create: (context) => SignInBloc(LoginApi()),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: home(),
        routes: {
          Login.routeName: (ctx) => Login(),
        },
      ),
    );
  }
}
