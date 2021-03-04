import 'dart:convert';

import 'package:login/logic/validators.dart';

enum EmailSignInFormType { signIn, register }

class EmailSignInModel with EmailAndPasswordValidators1 {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.submitted = false,
  });
  final String email;
  final String password;
  final bool isLoading;
  final bool submitted;

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInModel copyWith({
    String email,
    String password,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'isLoading': isLoading,
      'submitted': submitted,
    };
  }

  factory EmailSignInModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EmailSignInModel(
      email: map['email'],
      password: map['password'],
      isLoading: map['isLoading'],
      submitted: map['submitted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EmailSignInModel.fromJson(String source) =>
      EmailSignInModel.fromMap(json.decode(source));
}
