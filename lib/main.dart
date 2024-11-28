import 'package:career_bridge/Auth/signIn.dart';
import 'package:career_bridge/Auth/signup.dart';
import 'package:career_bridge/GestionStages/AddStagePage.dart';
import 'package:career_bridge/GestionStages/ListStage.dart';

import 'package:career_bridge/dashboardEntreprise/JobDashboard.dart';
import 'package:career_bridge/GetStarted/get_started_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:career_bridge/Home/home.dart'; // Import du fichier HomeScreen déjà créé

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions options = const FirebaseOptions(
    apiKey: "AIzaSyBjfg1pue7qxKpT8T0Rq93Jw0jYMLUep3s",
    appId: "1:847527364675:android:984f90d3dca3a0e6adacf6",
    messagingSenderId: "",
    projectId: "projetagile-e7282",
  );

  await Firebase.initializeApp(options: options);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Job Seeking",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const GetStartedScreen(), // Écran de démarrage
      routes: {
        '/home': (context) =>
            const HomeScreen(), 
        '/signIn': (context) =>
            const SignIn(),
        '/signUp':(context) =>
          const SignUpScreen(),
        '/dashboardEbtreprise':(context) =>
        const JobDashboard(),
        '/started': (context) => 
          const GetStartedScreen(),
        '/addInternship': (context) =>
         AddStagePage(),
        '/listStages': (context) =>
            const ListStage(),
      },
    );
  }
}
