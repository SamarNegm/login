import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/data/loginRepo.dart';
import 'package:login/logic/SignInBloc.dart';
import 'package:login/persentation/login_screen.dart';

import 'custom_raised_button.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  child: Image.asset('assets/images/logo.png')),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40),
                          child: Text('Best Way to invest your Mony'),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomRaisedButton(
                              borderRadius: 20,
                              child: Text('Login'),
                              height: 50,
                              color: Colors.purple,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(Login.routeName);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomRaisedButton(
                              borderRadius: 20,
                              child: Text(
                                'SignUp',
                                style: TextStyle(color: Colors.purple),
                              ),
                              height: 50,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(Login.routeName);
                              },
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
