// @dart=2.9
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:newapp_video_app/Components/admin.dart';
import 'package:newapp_video_app/Screens/Stories/add_new_stories.dart';
import 'package:newapp_video_app/Screens/Website.dart';
import 'package:newapp_video_app/Screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newapp_video_app/Screens/Main_user.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
 
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Video Website',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: WebsitePage(),
            routes: {
              "/Home":(context)=>   WebsitePage(),
              "/Admin": (content) => admin_Dashboard(),
              "/Add_Stories":(context)=> AddNewStories(),
              // "/Main_User": (content) =>const MainCase(),
            //   "/register": (content) => Register(),
              "/home": (content) => Home(),
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}

