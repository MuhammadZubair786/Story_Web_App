import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class AddNewStories extends StatefulWidget {
  @override
  _AddNewStoriesState createState() => _AddNewStoriesState();
}

class _AddNewStoriesState extends State<AddNewStories> {
  double progress = 0.0;
  var download = null;

  FirebaseFirestore db = FirebaseFirestore.instance;

   TextEditingController  storytitle = TextEditingController();

  TextEditingController question1 = TextEditingController();
  TextEditingController op1 = TextEditingController();
  TextEditingController op2 = TextEditingController();
  TextEditingController op3 = TextEditingController();
  TextEditingController  CorrectAns_1 = TextEditingController();

  TextEditingController question2 = TextEditingController();
  TextEditingController op2_1 = TextEditingController();
  TextEditingController op2_2 = TextEditingController();
  TextEditingController op2_3 = TextEditingController();
   TextEditingController CorrectAns_2 = TextEditingController();


  Future<void> submit() async {

    final title = storytitle.text;

  final q1 = question1.text;
  final op1_1 = op1.text;
  final op1_2 = op2.text;
  final op1_3 = op3.text;
  final correct_1 = CorrectAns_1.text;

  final q2 = question1.text;
  final op_2_1 = op2_1.text;
  final op_2_2 = op2_2.text;
  final op_2_3 = op2_3.text;
  final correct_2 = CorrectAns_2.text;



  var obj = {
    "Story":title,
    "question_1": q1,
    "Op1_1":op1_1,
    "Op1_2":op1_2,
    "Op1_3":op1_3,
    "Correct_1":correct_1,
    "question_2":q2,
    "Op2_1":op_2_1,
    "Op2_2":op_2_2,
    "Op2_3":op_2_3,
    "Correct_2":correct_2,
    "Video_Url":download
  };

print(obj);

// Get Id for current Added
// var collection = FirebaseFirestore.instance.collection('collection');
// var docRef = await collection.add(obj);
// var documentId = docRef.id;


await db.collection('Stories').doc().set(obj);
  }

  Future<void> uploadimg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      String fileName = result.files.first.name;

      UploadTask task = FirebaseStorage.instance
          .ref()
          .child("files/$fileName")
          .putData(file!);

      task.snapshotEvents.listen((event) {
        setState(() {
          progress = ((event.bytesTransferred.toDouble() /
                      event.totalBytes.toDouble()) *
                  100)
              .roundToDouble();

          print(progress);
        });
      });
      final snapshot = await task.whenComplete(() {});
      download = await snapshot.ref.getDownloadURL();

      print('Download-Link: $download');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("New Story App"),
        ),
        drawer: BuildDrawer(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: 600,
                    child: Center(
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 20),
                        elevation: 30,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: uploadimg,
                                  child: const Text("Upload Video"),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: Center(
                                    child: Container(
                                      height: 100.0,
                                      width: 100.0,
                                      child: LiquidCircularProgressIndicator(
                                        value: progress / 100,
                                        valueColor:
                                            const AlwaysStoppedAnimation(
                                                Colors.blue),
                                        backgroundColor: Colors.white,
                                        direction: Axis.vertical,
                                        center: Text(
                                          "$progress%",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black87,
                                              fontSize: 25.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                              children: [
                                Center(
                                  child: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(              
                                      "Story Title : ",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: storytitle,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "Title",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                ),

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Question 1 ",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Center(
                  child: Container(
                    width: 600,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Question : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: question1,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Option 1 : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: op1,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Option 2 : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: op2,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Option 3 : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: op3,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Correct Answer : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: CorrectAns_1,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,)
                ,
                 const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Question 2 ",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Center(
                  child: Container(
                    width: 600,
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Question : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: question2,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Option 1 : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: op2_1,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Option 2 : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: op2_2,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Option 3 : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: op2_3,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                           Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Correct Answer : ",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  color: Colors.grey[50],
                                  child: TextField(
                                    controller: CorrectAns_2,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ), 
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: submit, child: Text("Submit "))
                    ],
                  ),
                ),
               const SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Drawer BuildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Container(
            width: 300.0,
            height: 500.0,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(
                  "https://media.istockphoto.com/vectors/dark-abstract-background-vector-illustration-vector-id929619614?b=1&k=6&m=929619614&s=612x612&w=0&h=bzXWUYZ7R9wMSTmWANhfhh2ct3RAnOBVKMhqLDE1KiY="),
              // fit: BoxFit.cover
            )),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon((Icons.supervised_user_circle_rounded)),
                  color: Colors.white,
                  iconSize: 60,
                  onPressed: () {},
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      ("Admin"),
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      ("admin@gmail.com"),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            )),
          )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: (Row(
                  children: <Widget>[
                    // ...
                    Expanded(
                      child: Column(
                        children: <Widget>[Divider(color: Colors.black)],
                      ),
                    )
                  ],
                )),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context)=>Home()));
                },
                child: ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.home)),
                      color: Colors.red,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: const Text("Add New Storie")),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);
                },
                child: ListTile(
                    leading: IconButton(
                      icon: Icon((Icons.home)),
                      color: Colors.red,
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    title: const Text("View Stories")),
              ),
              ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.contact_page)),
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Search Specfic")),
              ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.app_blocking_rounded)),
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("About")),
              ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.settings_sharp)),
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Setting")),
              ListTile(
                  leading: IconButton(
                    icon: Icon((Icons.login_outlined)),
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                  title: Text("Log Out")),
            ],
          ),
          // GestureDetector(onTap: (){},child:ListTile(title:Text("hello"))),  //GestureDetector used for Drawer move one page to other
        ],
      ),
    );
  }
}
