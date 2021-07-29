import 'package:chat_flutter/screens/auth_screen.dart';
import 'package:chat_flutter/screens/chat_screen.dart';
import 'package:chat_flutter/screens/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Demo",
      theme: ThemeData(
        canvasColor: Colors.white30,
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (ctx,snapShot) {
       if(snapShot.connectionState==ConnectionState.waiting){
         return SplashScreen();
       }
        if(snapShot.hasData){
          return ChatScreen();
        }else{
          return AuthScreen();
        }
      },),
    );
  }
}


