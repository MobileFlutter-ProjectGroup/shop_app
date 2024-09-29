import 'dart:io';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  String loginTaskString = 'LOGIN';
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  void _showErrorDialog(String errorMsg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.error),
        iconColor: Colors.red,
        title: const Text('Authentation Error'),
        content: Text(errorMsg),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.login) {
        //Log user in

        await Provider.of<Auth>(context, listen: false)
            .logIn(_authData['email']!, _authData['password']!);
        // scaffoldMessage('SigIn Successfully');
      } else {
        //Sig user up

        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email']!, _authData['password']!);
        // scaffoldMessage('SignUp Successfully');
      }
    } on HttpException catch (error) {
      var errorMsg = 'Authentication Fail!';
      final message = error.message;
      if (message.contains('EMAIL_EXITS')) {
        errorMsg = 'The email address is already in use by another account.';
      } else if (message.contains('OPERATION_NOT_ALLOWED')) {
        errorMsg = 'Password sign-in is disabled for this app.';
      } else if (message.contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMsg =
            'We have blocked all requests from this device due to unusual activity. Try again later.';
      } else if (message.contains('EMAIL_NOT_FOUND')) {
        errorMsg =
            'There is no user record corresponding to this identifier. The user may have been deleted.';
      } else if (message.contains('INVALID_PASSWORD')) {
        errorMsg =
            'The password is invalid or the user does not have a password.';
      } else if (message.contains('USER_DISABLED')) {
        errorMsg = 'The user account has been disabled by an administrator.';
      } else if (message.contains('OPERATION_NOT_ALLOWED')) {
        errorMsg = 'Anonymous user sign-in is disabled for this app.';
      } else {
        errorMsg = 'Something worng in authentitation';
      }
      _showErrorDialog(errorMsg);
    } catch (error) {
      var errorMsg = 'can\'t authenticate.Place try again.';
      _showErrorDialog(errorMsg);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void scaffoldMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
        loginTaskString = 'SIGN UP';
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
        loginTaskString = 'LOGIN';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.all(40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: _authMode == AuthMode.signup ? 400 : 320,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signup ? 400 : 320),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                TextFormField(
                  enabled: _authMode == AuthMode.signup,
                  decoration:
                      const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _authMode == AuthMode.signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                          return null;
                        }
                      : null,
                  //
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).primaryTextTheme.labelLarge?.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8.0),
                    ),
                    child: Text(
                      loginTaskString,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 4),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    loginTaskString == 'LOGIN' ? 'SIGN UP?' : 'LOGIN?',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
