import 'package:anselm/screen_arguments.dart';
import 'package:anselm/ui/page/video/video_detail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './ui/page/register.dart';
import './ui/page/login.dart';
import './ui/result_screen/done.dart';

import 'package:anselm/page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter camera',
      debugShowCheckedModeBanner: false,
      home: const Login(),
      initialRoute: RegisterPage.id,
      routes: {
        Login.id: (contetx) => const Login(),
        RegisterPage.id: (context) => const RegisterPage(),
        Done.id: (context) => const Done(),
        HomePage.id: (context) => const HomePage(),
      },
      onGenerateRoute: (settings) {
        final agr = settings.arguments;
        if (settings.name == VideoDetail.routeName) {}
        return MaterialPageRoute(builder: (ctx) {
          ScreenArguments? agruments = agr as ScreenArguments?;
          return VideoDetail(
              agruments!.label!, agruments.uri!, agruments.location!);
        });
      },
    );
  }
}
