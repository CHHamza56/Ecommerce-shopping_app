// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInDemo extends StatefulWidget {
  @override
  _GoogleSignInDemoState createState() => _GoogleSignInDemoState();
}

class _GoogleSignInDemoState extends State<GoogleSignInDemo> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      if (_googleSignIn.currentUser != null) {
        setState(() {
          _currentUser = _googleSignIn.currentUser;
          _contactText =
              "Name: ${_currentUser!.displayName}\nEmail: ${_currentUser!.email}";
        });
      }
    } catch (error) {
      print('Sign in error: $error');
      _showErrorDialog('Sign in failed. Please try again.');
    }
  }

  Future<void> _handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      setState(() {
        _currentUser = null;
        _contactText = '';
      });
    } catch (error) {
      print('Sign out error: $error');
      _showErrorDialog('Sign out failed. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Name: ${user.displayName}\nEmail: ${user.email}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Demo'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentUser != null)
              Column(
                children: <Widget>[
                  ListTile(
                    leading: GoogleUserCircleAvatar(identity: _currentUser!),
                    title: Text(_currentUser!.displayName ?? ''),
                    subtitle: Text(_currentUser!.email),
                  ),
                  const Text("Signed in successfully."),
                  ElevatedButton(
                    onPressed: _handleSignOut,
                    child: const Text('SIGN OUT'),
                  ),
                  Text(_contactText),
                ],
              )
            else
              Column(
                children: <Widget>[
                  const Text("You are not currently signed in."),
                  ElevatedButton(
                    onPressed: _handleSignIn,
                    child: const Text('SIGN IN'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
