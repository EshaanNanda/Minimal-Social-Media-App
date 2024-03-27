import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/auth/auth.dart';
import 'package:minimal_social_media/firebase_options.dart';
import 'package:minimal_social_media/pages/profile_page.dart';
import 'package:minimal_social_media/pages/register_page.dart';
import 'package:minimal_social_media/pages/users_page.dart';
import 'package:minimal_social_media/theme/dark_mode.dart';
import 'package:minimal_social_media/theme/light_mode.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/first',
      routes: {
        '/first': (context) => AuthPage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => ProfilePage(),
        '/user':(context)=>UsersPage(),
        '/login':(context)=> LoginPage()
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      theme: lightmode,
      darkTheme: darkmode,
    );
  }
}
