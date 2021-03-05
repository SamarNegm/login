import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/data/loginRepo.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LoginPasswordChanged && o.password == password;
  }

  @override
  int get hashCode => password.hashCode;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String pass;
  const LoginSubmitted({this.email, this.pass});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class PassChaned extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class IsLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class Loaded extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignInBloc extends Bloc<LoginEvent, LoginState> {
  SignInBloc({
    @required this.loginApi,
  }) : super(null);
  final LoginApi loginApi;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPasswordChanged) {
    } else if (event is IsLoading) {
    } else if (event is LoginSubmitted) {
      yield IsLoading();
      try {
        await LoginApi().signup(event.email, event.pass);
        yield Loaded();
      } catch (e) {
        throw e;
      }
    }
  }
}
