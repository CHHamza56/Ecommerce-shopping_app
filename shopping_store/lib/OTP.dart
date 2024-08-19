// ignore_for_file: prefer_const_declarations, prefer_interpolation_to_compose_strings, use_build_context_synchronously, camel_case_types, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Otp extends StatefulWidget {
  @override
  _otpState createState() => _otpState();
}

class _otpState extends State<Otp> {
  final TextEditingController _emailController = TextEditingController();
  String _generateOTP() {
    final Random _random = Random();
    final int otp = 100000 + _random.nextInt(900000);
    return otp.toString();
  }

  Future<void> _sendOTP(String email) async {
    final String otp = _generateOTP();
    final String username = 'chhamzajamil8@gmail.com';
    final String password = 'rtdl dwno wfeu chyp';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'shopping app')
      ..recipients.add(email)
      ..subject = 'Your OTP Code'
      ..text = 'Your OTP code is $otp';
    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('OTP sent to $email'),
      ));
    } on MailerException catch (e) {
      print('Message not sent. \n' + e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send OTP'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Enter your email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String email = _emailController.text;
                _sendOTP(email);
              },
              child: Text('Send OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
