import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: must_be_immutable
class GoogleDone extends StatelessWidget {
  late GoogleSignIn _googleSignIn;
  late User _user;

  GoogleDone(User user, GoogleSignIn signIn, {super.key}) {
    _user = user;
    _googleSignIn = signIn;

    print(_user);
    print(_googleSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ClipOval(
            //   child: _user.photoUrl != null
            //       ? Image.network(
            //           _user.photoUrl,
            //           width: 100,
            //           height: 100,
            //           fit: BoxFit.cover,
            //         )
            //       : Image.network(
            //           'https://lh3.googleusercontent.com/6UgEjh8Xuts4nwdWzTnWH8QtLuHqRMUB7dp24JYVE2xcYzq4HA8hFfcAbU-R-PC_9uA1',
            //           width: 100,
            //           height: 100,
            //           fit: BoxFit.cover,
            //         ),
            // ),
            // Text(_user.displayName,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            TextButton(
              onPressed: () {
                _googleSignIn.signOut();
                Navigator.pop(context);
              },
              child: Text('Google sign in Done!'),
            ),
          ],
        ),
      ),
    );
  }
}
