import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/data/email_sign_in_model.dart';

import 'package:login/data/loginRepo.dart';

class LoginEvent extends Equatable {
  const LoginEvent();
  List<Object> get props => [];
}

class start extends LoginEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;
  @override
  // TODO: implement props
  List<Object> get props => [username];
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
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String pass;

  const LoginSubmitted({this.email, this.pass});

  @override
  // TODO: implement props
  List<Object> get props => [email, pass];
}

class LoginState extends Equatable {
  EmailSignInModel model = EmailSignInModel();
  @override
  // TODO: implement props
  List<Object> get props => [model];
}

class notLogedIn extends LoginState {
  // TODO: implement props
  List<Object> get props => [];
}

class emailErorr extends LoginState {
  // TODO: implement props

  List<Object> get props => [];
}

class IsLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class passwordError extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class both extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Loaded extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignInBloc extends Bloc<LoginEvent, LoginState> {
  SignInBloc(this.loginApi) : super(notLogedIn());

  LoginApi loginApi;
  EmailSignInModel stateModel = LoginState().model;
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    print(';');
    if (event is LoginPasswordChanged) {
      stateModel = state.model.copyWith(password: event.password);
    } else if (event is LoginUsernameChanged) {
      stateModel = state.model.copyWith(email: event.username);
    } else if (event is IsLoading) {
    } else if (event is LoginSubmitted) {
      stateModel =
          state.model.copyWith(email: event.email, password: event.pass);

      if (!stateModel.emailValidator.isValid(event.email)) {
        yield emailErorr();
      }
      if (!stateModel.passwordValidator.isValid(event.pass)) {
        yield passwordError();
      }
      if (!stateModel.passwordValidator.isValid(event.pass) &&
          !stateModel.emailValidator.isValid(event.email)) {
        yield both();
      }
      if (stateModel.canSubmit) {
        //todo add vALidation

        yield IsLoading();
        try {
          await LoginApi().signup(event.email, event.pass);
          yield Loaded();
        } catch (e) {
          throw e;
        }
      }
    } else {
      print('hello');
      yield notLogedIn();
    }
  }
}
