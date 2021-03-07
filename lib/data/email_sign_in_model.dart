import 'dart:convert';

import 'package:login/logic/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators1 {
  EmailSignInModel({
    this.email = '',
    this.password = '',
  });
  final String email;
  final String password;

  bool get canSubmit {
    return emailValidator.isValid(email) && passwordValidator.isValid(password);
  }

  String get passwordErrorText {
    bool showErrorText = !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory EmailSignInModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EmailSignInModel(
      email: map['email'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailSignInModel.fromJson(String source) =>
      EmailSignInModel.fromMap(json.decode(source));
}
