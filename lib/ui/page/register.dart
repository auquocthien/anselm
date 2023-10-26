import 'package:anselm/page.dart';
import 'package:flutter/material.dart';
// import '../result_screen/done.dart';
import '../result_screen/google_done.dart';
import '../page/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:validators/validators.dart' as validator;

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  static String id = '/RegisterPage';

  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String name = '';
  late String email = '';
  late String password = '';

  bool _showSpinner = false;

  bool _wrongEmail = false;
  bool _wrongPassword = false;

  String _emailText = 'Please use a valid email';
  String _passwordText = 'Please use a strong password';

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['name', 'email']);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> _handleSignIn() async {
    // hold the instance of the authenticated user
    late User user;
    // flag to check whether we're signed in already
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      // if so, return the current user
      user = await _auth.currentUser!;
    } else {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      user = (await _auth.signInWithCredential(credential)).user!;
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    Navigator.pushNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                    'Đăng kí',
                    style: TextStyle(
                        fontSize: 40,
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: const InputDecoration(
                          hintText: '',
                          labelText: 'Họ và tên',
                        ),
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: _wrongEmail ? _emailText : null,
                        ),
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu',
                          errorText: _wrongPassword ? _passwordText : null,
                        ),
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) =>
                                  const EdgeInsets.symmetric(vertical: 5)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.blue),
                      // shape: ContinuousRectangleBorder(
                      //   side: BorderSide(
                      //       width: 0.5, color: Colors.grey[400]),
                      // ),
                    ),
                    // padding: EdgeInsets.symmetric(vertical: 10.0),
                    // color: Color(0xff447def),
                    onPressed: () async {
                      setState(() {
                        _wrongEmail = false;
                        _wrongPassword = false;
                      });
                      try {
                        if (validator.isEmail(email) &
                            validator.isLength(password, 6)) {
                          setState(() {
                            _showSpinner = true;
                          });
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          if (newUser != null) {
                            print('user authenticated by registration');
                            Navigator.pushNamed(context, HomePage.id);
                          }
                        }

                        setState(() {
                          if (!validator.isEmail(email)) {
                            _wrongEmail = true;
                          } else if (!validator.isLength(password, 6)) {
                            _wrongPassword = true;
                          } else {
                            _wrongEmail = true;
                            _wrongPassword = true;
                          }
                        });
                      } catch (e) {
                        setState(() {
                          _wrongEmail = true;
                          if (e == 'email-already-in-use') {
                            _emailText =
                                'The email address is already in use by another account';
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Đăng kí',
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
                          // padding: EdgeInsets.symmetric(vertical: 5.0),
                          // color: Colors.white,
                          // shape: ContinuousRectangleBorder(
                          //   side:
                          //       BorderSide(width: 0.5, color: Colors.grey[400]),
                          // ),
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
                          // padding: EdgeInsets.symmetric(vertical: 5.0),
                          // color: Colors.white,
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
                          Navigator.pushNamed(context, Login.id);
                        },
                        child: const Text(
                          ' Đăng nhập',
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
