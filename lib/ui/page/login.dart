import 'package:anselm/ui/result_screen/done.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../result_screen/google_done.dart';
import '../page/register.dart';
import '../../page.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import '../result_screen/done.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;

User? _user;

// ignore: must_be_immutable
class Login extends StatefulWidget {
  static String id = '/LoginPage';

  const Login({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  late String email = '';
  late String password = '';

  bool _showSpinner = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _handleSignIn() async {
    // hold the instance of the authenticated user
//    FirebaseUser user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      _user = await _auth.currentUser!;
    } else {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      _user = (await _auth.signInWithCredential(credential)).user;
    }

    return _user;
  }

  void onGoogleSignIn(BuildContext context) async {
    setState(() {
      _showSpinner = true;
    });

    User? user = await _handleSignIn();

    setState(() {
      _showSpinner = true;
    });

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => GoogleDone(user!, _googleSignIn)));
    Navigator.pushNamed(context, HomePage.id);
  }

  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: Colors.blueAccent,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/images/background.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Đăng nhập',
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 190,
                  ),
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: '',
                          labelText: 'Email',
                          errorText: _wrongEmail ? emailText : null,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          password = value;
                        },
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: '',
                          labelText: 'Mật khẩu',
                          errorText: _wrongPassword ? passwordText : null,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 5.0)),
                    onPressed: () async {
                      setState(() {
                        _showSpinner = true;
                      });
                      try {
                        setState(() {
                          _wrongEmail = false;
                          _wrongPassword = false;
                        });
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, HomePage.id);
                        }
                      } catch (e) {
                        print(e);
                        if (e == 'wrong-password') {
                          setState(() {
                            _wrongPassword = true;
                          });
                        } else {
                          setState(() {
                            emailText = 'User doesn\'t exist';
                            passwordText = 'Please check your email';

                            _wrongPassword = true;
                            _wrongEmail = true;
                          });
                        }
                      }
                    },
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                      const Text(
                        'Hoặc',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          height: 1.0,
                          width: 60.0,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith<
                                    EdgeInsetsGeometry>(
                                (Set<MaterialState> states) =>
                                    const EdgeInsets.symmetric(vertical: 5)),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) => Colors.white),
                            // shape: ContinuousRectangleBorder(
                            //   side: BorderSide(
                            //       width: 0.5, color: Colors.grey[400]),
                            // ),
                          ),
                          onPressed: () {
                            onGoogleSignIn(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Google',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.resolveWith<
                                    EdgeInsetsGeometry>(
                                (Set<MaterialState> states) =>
                                    const EdgeInsets.symmetric(vertical: 5)),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) => Colors.white),
                            // shape: ContinuousRectangleBorder(
                            //   side: BorderSide(
                            //       width: 0.5, color: Colors.grey[400]),
                            // ),
                          ),
                          // shape: ContinuousRectangleBorder(
                          //   side:
                          //       BorderSide(width: 0.5, color: Colors.grey[400]),
                          // ),
                          onPressed: () {
                            //TODO: Implement facebook functionality
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/facebook.png',
                                  fit: BoxFit.cover, width: 40.0, height: 40.0),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Facebook',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: const Text(
                          'Đăng kí',
                          style: TextStyle(fontSize: 25.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
