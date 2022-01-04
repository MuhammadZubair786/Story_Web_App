import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultCard extends StatefulWidget {
  var userUid;
  var score;

  ResultCard(this.userUid,this.score);

  @override
  _ResultCardState createState() => _ResultCardState(userUid,score);
}

class _ResultCardState extends State<ResultCard> {
  var userUid;
  var score;
  _ResultCardState(this.userUid,this.score);

  // List<dynamic> list =[];
  var userName = '';
  var Email ="";

  @override
  initState() {
    super.initState();
    _getUserName();
    print(userUid);

  }

  // ignore: unused_element
   _getUserName() async {
     var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(userUid)
        .get();
    var p = await data.data();
    print(p);
    print(p!.length);
    print(p['email']);
    print(p['name']);

    setState(() {
          userName = p['name'];
          Email=p['email'];
          
          
        });

    // var obj ={
    //   "Email":p['email'],
    //   "Name":p['name']
    // };
    // list.add(obj);


  // return list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Center(child: Text(" Quiz Result ")),
      ),
      body:  Builder(
              builder : (BuildContext context) => Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0, left: 360),
              child: Container(
                width: 700,
                height: 400,
                child: Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: [
                          Center(child: Center(child: Text("Quiz Result",style: TextStyle(fontSize: 30),))),
                          Center(
                            child: Padding(
                              padding: const  EdgeInsets.only(top:28.0,left:70),
                              child: Row(
                                children: [
                                  Center(child: Text("Student Name : ",style: TextStyle(fontSize: 30),)),
                                  Center(child: Text("${userName} : ",style: TextStyle(fontSize: 30),))
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top:28.0,left:70),
                              child: Row(
                                children: [
                                  Center(child: Text("Student Email: ",style: TextStyle(fontSize: 30),)), 
                                Center(child: Text("${Email}: ",style: TextStyle(fontSize: 30),))],
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top:28.0,left:70),
                              child: Row(
                                children: [
                                  Center(child: Text("Score : ",style: TextStyle(fontSize: 30),)), 
                                Center(child: Text("${score}: ",style: TextStyle(fontSize: 30),))],
                              ),
                            ),
                          )
                        ],
                      )),
                      ),
              ),
            
          ],
        )),
      ),
    ));
  }
}
