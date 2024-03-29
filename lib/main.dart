import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oedu/firebase_options.dart';
import 'package:oedu/screens/login.dart';
import 'package:oedu/theme/color.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'O.Edu',
      theme: ThemeData(
       primaryColor: AppColor.primary,
      ),
      home:const LoginPage(),
    );
  }
}


