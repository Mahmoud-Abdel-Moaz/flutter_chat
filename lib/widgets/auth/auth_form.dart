import 'dart:io';

import 'package:chat_flutter/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,File image,
      bool isLogin, BuildContext ctx) submitFn;
  bool _isLoading;

  AuthForm(this.submitFn, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = "";
  String _password = "";
  String _username = "";
  File? _userImageFile;

  void _pickedImage(File pickedImage){
    _userImageFile=pickedImage;
  }

  void _submit() {
    final isValid = _formKey.currentState!.validate();
    /*عشا اقفل الكيبور لما يدوس على لوجن او ساناب*/
    FocusScope.of(context).unfocus();

  if  (!_isLogin&&_userImageFile==null){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Please pick an image"),
      backgroundColor: Theme.of(context).errorColor,
    ));
    return;
  }

    if (isValid) {
      _formKey..currentState!.save();
      /*  print(_username);
      print(_email);
      print(_password);*/
      widget.submitFn(
          _email.trim(), _password.trim(), _username.trim(),_userImageFile! ,_isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)UserImagePicker(_pickedImage),
                  TextFormField(
                    autocorrect: false,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    key: ValueKey('email'),
                    validator: (val) {
                      if (val!.isEmpty || !val.contains('@')) {
                        return "Please Enter a Valid email Address";
                      }
                      return null;
                    },
                    onSaved: (val) => _email = val!,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        InputDecoration(labelText: "Enter Email Address"),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      autocorrect: true,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.words,
                      key: ValueKey('username'),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 7) {
                          return "Please Enter a Valid User name";
                        }
                        return null;
                      },
                      onSaved: (val) => _username = val!,
                      decoration: InputDecoration(labelText: "Enter Username"),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (val) {
                      if (val!.isEmpty || val.length < 7) {
                        return "Please Enter at least 7 characters";
                      }
                      return null;
                    },
                    onSaved: (val) => _password = val!,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(labelText: "Enter Password"),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    RaisedButton(
                        child: Text(_isLogin ? "Login" : "Sign Up"),
                        onPressed: _submit),
                  if (!widget._isLoading)
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? "Create new account"
                            : "I already have an account"))
                ],
              )),
        ),
      ),
    );
  }
}
