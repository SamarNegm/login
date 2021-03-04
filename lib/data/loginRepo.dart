import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/data/email_sign_in_model.dart';
import 'package:login/logic/http_exception.dart';

class LoginApi {
  Future<void> authentication(String email, String password, String Url) async {
    final url = Url;
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw (error);
    }
  }

  EmailSignInModel parsedJson(final response) {
    final jsonDecoded = json.decode(response);

    final jsondata = jsonDecoded["main"];

    return EmailSignInModel.fromJson(jsondata);
  }

  Future<void> signup(String email, String password) async {
    const url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDyHRnY7EodZtDnI5Dd3squv0a2XoT9M-E';
    return authentication(email, password, url);
  }

  Future<void> signin(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDyHRnY7EodZtDnI5Dd3squv0a2XoT9M-E';
    return authentication(email, password, url);
  }
}
