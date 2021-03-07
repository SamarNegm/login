import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/logic/SignInBloc.dart';
import 'package:login/persentation/custom_raised_button.dart';
import 'package:login/persentation/platform_exception_alert_dialog.dart';

class LoginWithEmailAndPass extends StatefulWidget {
  LoginWithEmailAndPass();

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

    final bloc = BlocProvider.of<SignInBloc>(context);

    await bloc.add(LoginSubmitted(
        email: _emailController.text,
        pass: _passwordController.text,
        context: context));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
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
              fontWeight: FontWeight.normal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: TextField(
              key: Key('t1'),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(_pass);
                print('onsubmitted' + _emailController.text);
                bloc.add(LoginUsernameChanged(_emailController.text));
              },
              controller: _emailController,
              focusNode: _emailFn,
              decoration: InputDecoration(
                errorText: bloc.state is emailErorr || bloc.state is both
                    ? bloc.stateModel.emailErrorText
                    : null,
                labelStyle: TextStyle(fontSize: 12, color: Colors.black54),
                labelText: 'E-Mail',
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.black54,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: Colors.black54),
              onChanged: (value) {
                bloc.add(LoginUsernameChanged(value));
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 12, right: 12, bottom: 12),
            child: TextField(
              key: Key('t2'),
              focusNode: _pass,
              obscureText: true,
              decoration: InputDecoration(
                  errorText: bloc.state is passwordError || bloc.state is both
                      ? bloc.stateModel.passwordErrorText
                      : null,
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
              onSubmitted: (value) {
                bloc.add(LoginPasswordChanged(value));
              },
            ),
          ),
          bloc.state is IsLoading
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
