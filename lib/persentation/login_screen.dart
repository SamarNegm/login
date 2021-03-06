import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/logic/SignInBloc.dart';
import 'package:login/persentation/loginWithemailAndPass.dart';

class Login extends StatelessWidget {
  static const routeName = '/login';
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    //print(bloc.state.toString());
    return BlocBuilder<SignInBloc, LoginState>(
        cubit: bloc,
        builder: (context, state) {
          if (state is Loaded) {
            return Scaffold(
              body: Container(
                child: Center(child: Text('hi')),
              ),
            );
          } else {
            print('why');
            return Scaffold(
                body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black12,
                              Colors.black54,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0, 1],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 30,
                                                right: 30,
                                                left: 30),
                                            child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .15,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .15,
                                                child: Image.asset(
                                                    'assets/images/logo.png')),
                                          ),
                                        ]),
                                    // StreamBuilder<bool>(
                                    //     initialData: false,
                                    //     stream: bloc.isLoadingStram,
                                    //     builder: (context, snapshot) {
                                    //       return
                                    Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Center(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .6,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .98,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60.0),
                                                  ),
                                                  elevation: 8.0,
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 30,
                                                              left: 16,
                                                              right: 16,
                                                              bottom: 30),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            LoginWithEmailAndPass(),

                                                            Center(
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        'i\'m a new user'),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {},
                                                                        child:
                                                                            Text(
                                                                          'Sign Up',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color:
                                                                                Colors.purple,
                                                                          ),
                                                                        )),
                                                                  ]),
                                                            ),

                                                            //   FlatButton(onPressed: (){} , label: Text('Continue with google'))
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ])))
                    ])));
          }
        });
  }
}
