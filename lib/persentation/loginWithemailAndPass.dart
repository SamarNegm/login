import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/logic/SignInBloc.dart';
import 'package:login/persentation/custom_raised_button.dart';
import 'package:login/persentation/platform_exception_alert_dialog.dart';

class LoginWithEmailAndPass extends StatefulWidget {
  LoginWithEmailAndPass(this.bloc);
  SignInBloc bloc;

  @override
  _LoginWithEmailAndPassState createState() => _LoginWithEmailAndPassState();
}

class _LoginWithEmailAndPassState extends State<LoginWithEmailAndPass> {
  FocusNode _emailFn = FocusNode();

  FocusNode _pass = FocusNode();

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFn.dispose();
    _pass.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    try {
      //  await widget.bloc.submit(true);
      // Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Log in failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Login',
            style: TextStyle(
                fontSize: 20,
                color: Colors.purple,
                fontWeight: FontWeight.normal),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: TextFormField(
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_pass);
              },
              controller: _emailController,
              focusNode: _emailFn,
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12, color: Colors.black54),
                  labelText: 'E-Mail',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.black54,
                  )),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.black54),
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Invalid email!';
                }
              },
              onSaved: (value) {
                //    widget.bloc.updateEmail(value);
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 12, right: 12, bottom: 12),
            child: TextFormField(
              focusNode: _pass,
              obscureText: true,
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 12, color: Colors.black54),
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black54,
                  )),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              controller: _passwordController,
              style: TextStyle(color: Colors.black54),
              validator: (value) {
                if (value.isEmpty || value.length < 4) {
                  return 'Invalid Passord!';
                }
              },
              onSaved: (value) {
                // widget.bloc.updatePassword(value);
              },
            ),
          ),
          1 == 2
              //   model.isLoading
              ? CircularProgressIndicator()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomRaisedButton(
                      height: 50,
                      borderRadius: 40,
                      onPressed: _submit,
                      child: Text('Log In',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
