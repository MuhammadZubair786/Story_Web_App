// ignore: file_names
// ignore_for_file: file_names

// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:newapp_video_app/Screens/Stories/Quiz.dart';
import 'package:newapp_video_app/Screens/Stories/detail_Stories.dart';

import "package:video_controls/video_controls.dart";

import '../PlayGame.dart';

String url =
    "https://firebasestorage.googleapis.com/v0/b/videoapp-1f453.appspot.com/o/files%2F2021-11-16%2010-21-27.mkv?alt=media&token=670cd878-0829-4bb0-904b-2d7d601bf2c0";

class HomePage extends StatefulWidget {
  var value;
  var userUid;

  HomePage(this.value, this.userUid);
  @override
  HomePageState createState() => HomePageState(value, userUid);
}

class HomePageState extends State<HomePage> {
  var value;
  var userUid;

// String url="";
  HomePageState(this.value, this.userUid);

//   Future<void> data() async {

//  var data = await FirebaseFirestore.instance.collection("Stories").doc(value.uid).get();
//     print("Data : ${data.data()}");
//   }

  List<Model> list = [];
  Future<List<dynamic>> _getUserName() async {
// List id =[];
// var collection = FirebaseFirestore.instance.collection('Stories');
// var querySnapshots = await collection.get();
// for (var snapshot in querySnapshots.docs) {
//   var documentID = snapshot.id; // <-- Document ID
//   print("Id : ${documentID}");
//   id.add(documentID);
// }
// print(id);

    var data = await FirebaseFirestore.instance
        .collection("Stories")
        .doc(value.uid)
        .get();
    var p = await data.data();
    print(p);
    print(p!.length);
    print(p['Story']);

    for (int i = 0; i < 1; i++) {
      Model model = Model(
          p['Story'],
          p['Video_Url'],
          value.uid,
          p['question_1'],
          p['Op1_1'],
          p['Op1_2'],
          p['Op1_3'],
          p["Correct_1"],
          p['question_2'],
          p['Op2_1'],
          p['Op2_2'],
          p['Op2_3'],
          p["Correct_2"]);
      print(data);
      list.add(model);
    }
    // //  Navigator.pushNamed(context,'/Main_User');
    print(list);

    return list;
  }

  @override
  initState() {
    super.initState();
    // _ge   tUserName();
    //   print(value.title);
    // print(value.content);
    print("Url :${value.Video_Url}");
    print("Uid : ${value.uid} :user uid : $userUid");

    // url=value.Video_Url;
    setState(() {
      controller = VideoController.network(value.Video_Url);
      // controller.play();
      // controller.setVolume(2);
    });
  }

  late VideoController controller;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("video_controls Demo")),
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: const BoxConstraints(),
                child: Column(children: [
                  Center(
                    child: Text(value.Story,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3),
                  ),
                  const SizedBox(height: 30),
                  // ignore: avoid_unnecessary_containers
                  Center(
                    child: Container(
                        height: 600,
                        padding: new EdgeInsets.all(10),
                        child: VideoPlayer(controller)),
                  ),

                  // Text("Question"),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => MyHomePage()));
                    },
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        // decoration: const BoxDecoration(
                        //   image: DecorationImage(
                        //     image: NetworkImage(
                        //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXqBx6RiJv1y1GR29H2lVvz6wbzAmQYmLJOw&usqp=CAU"),
                        //     fit: BoxFit.fitWidth,
                        //     alignment: Alignment.topCenter,
                        //   ),
                        // ),
                        height: 100,
                        width: 400,
                        child: ListTile(
                          leading: const Icon(Icons.album, size: 50),
                          title: SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Column(
                                  children: [
                                    Text(
                                      "Play Game",
                                      // '${snapshot.data[index].q_1}'
                                      // ,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 25),
                                    ),
                                    // Text(
                                    //   'Play',
                                    //   style: const TextStyle(
                                    //       color: Colors.black, fontSize: 25),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // subtitle: Text('TWICE'),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(40),
                      child: FutureBuilder<List<dynamic>>(
                        
                        future: _getUserName(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            print(snapshot);
                            return Padding(
                              padding: const EdgeInsets.only(left:430.0),
                              
                              child: Center(
                                
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  controller: ScrollController(keepScrollOffset: false),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  childAspectRatio: (1 / .25),
                                  children:
                                      List.generate(snapshot.data.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) => QuizTime(
                                                    value = snapshot.data,
                                                    userUid = userUid
                                                  )),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          // Container(
                                          //   width: 200,
                                          //   height:100,
                                          //   decoration: BoxDecoration(
                                          //     image: DecorationImage(
                                          //         image: NetworkImage(
                                          //             "${ snapshot.data[index].email}"),
                                          //         fit: BoxFit.cover),
                                          //   ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Card(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(15.0),
                                                  ),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          blurRadius: 2,
                                                        ),
                                                      ],
                                                    ),
                                                    // decoration: const BoxDecoration(
                                                    //   image: DecorationImage(
                                                    //     image: NetworkImage(
                                                    //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXqBx6RiJv1y1GR29H2lVvz6wbzAmQYmLJOw&usqp=CAU"),
                                                    //     fit: BoxFit.fitWidth,
                                                    //     alignment: Alignment.topCenter,
                                                    //   ),
                                                    // ),
                                                    height: 100,
                                                    width: 400,
                                                    child: ListTile(
                                                      leading: const Icon(Icons.album,
                                                          size: 50),
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets.all(8.0),
                                                        child: MouseRegion(
                                                          cursor:
                                                              SystemMouseCursors.click,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "Start Quiz ",
                                                                // '${snapshot.data[index].q_1}'
                                                                // ,
                                                                style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 25),
                                                              ),
                                                              Text(
                                                                '',
                                                                style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 25),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // subtitle: Text('TWICE'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 80,)
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                  ),
                ]))),
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    print("UserUid :" + userUid);
  }
}

class Model {
  // {address: hyd, name: Asad, email: zubair@gmail.com, uid: woEIcxDMEQd2gL4CuLDcPkQTHF62, password:
// 123456}
  String Story,
      Video_Url,
      uid,
      q_1,
      op_1_1,
      op_1_2,
      op_1_3,
      correct_1,
      q_2,
      op_2_1,
      op_2_2,
      op_2_3,
      correct_2;

  Model(
      this.Story,
      this.Video_Url,
      this.uid,
      this.q_1,
      this.op_1_1,
      this.op_1_2,
      this.op_1_3,
      this.correct_1,
      this.q_2,
      this.op_2_1,
      this.op_2_2,
      this.op_2_3,
      this.correct_2);
}
