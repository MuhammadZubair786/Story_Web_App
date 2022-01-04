import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp_video_app/Screens/Main_user.dart';
import 'package:newapp_video_app/Screens/Stories/detail_Stories.dart';

class login_User extends StatefulWidget {
  const login_User({Key? key}) : super(key: key);

  @override
  _login_UserState createState() => _login_UserState();
}

class _login_UserState extends State<login_User> {
  @override
  final TextEditingController useremailController = TextEditingController();
  final TextEditingController userpasswordController = TextEditingController();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();


      List<Model> list=[];
      var userUid;

  Future<void> _getUserName() async {
    //       final DocumentReference document =   FirebaseFirestore.instance.collection("posts")
    //       .orderBy("liked", descending: true).get();
    // });
 
    //  final data =  await FirebaseFirestore.instance.collection("users").get(); //get the data
    // print(data);

    // List data =[];

//  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").get();
//   for (int i = 0; i < querySnapshot.docs.length; i++) {
//     var a = querySnapshot.docs[i];
//     var email = a.data();

//   }

//   }
    // QuerySnapshot querySnapshot =
    //     await FirebaseFirestore.instance.collection("users").get();

    // // Get data from docs and convert map to List
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    // // ignore: avoid_print
    // print(json.decode(allData)[0]["email"]);

     var data=await FirebaseFirestore.instance.collection("users").get();

     for(int i=0;i<data.docs.length;i++){
        Model model=Model(
          data.docs[i].data()['email'], 
          data.docs[i].data()['name'],
          data.docs[i].data()['uid'],
          data.docs[i].data()['address'],
           data.docs[i].data()['password']);
     print(data.docs[i].data()['email']);
     list.add(model);
     }
    //  Navigator.of(context).push(
    // MaterialPageRoute(builder: (_) =>MainCase()));
                            
     print(list);
  }

  

  login() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final String email = useremailController.text;
    final String password = userpasswordController.text;

    if (email == '') {
      Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          });

      AlertDialog alert = AlertDialog(
        title: Center(child: Text("Empty Value")),
        content: Text("Plz Enter Your  Email Address"),
        actions: [
          okButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else if (password == '') {
      Widget okButton = TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          });

      AlertDialog alert = AlertDialog(
        title: Center(child: Text("Empty Value")),
        content: Text("Plz Enter Your Password "),
        actions: [
          okButton,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      print(email);
      print(password);

      try {
        final UserCredential user = await auth.signInWithEmailAndPassword(
            email: email, password: password);
        final DocumentSnapshot snapshot =
            await db.collection('users').doc(user.user!.uid).get();

        print('User Email : ${user.user!.email}');
        print('User Name : ${user.user!.displayName}');
        print(user.user!.uid);
        // var document = await FirebaseFirestore.instance.collection('users').doc('TESTID1');
        FirebaseFirestore.instance
            .collection('COLLECTION')
            .doc('ID')
            .get()
            .then(
                (DocumentSnapshot) => print(DocumentSnapshot.data.toString()));
                  


        ;
        // FirebaseFirestore.instance
        //     .collection('users')
        //     .get()
        //     .then((QuerySnapshot querySnapshot) {
        //   querySnapshot.docs.forEach((doc) {
        //     print(doc["email"]);
        //   });
        // });

        // final data = snapshot.data()!;
        // print(data);

        // if (data != null) {
        //   print(data.runtimeType);
        //   // List<Map<String, dynamic>> = json.decode(snapshot.data());

        // }

        AlertDialog alert = const AlertDialog(
          title: Center(child: Text("Success Login ")),
          content: Text("Click Ok Button & Plz Wait"),
          
        );

        return showDialog(
          context: context,
          builder: (BuildContext context) {
           Navigator.of(context).push(
    MaterialPageRoute(builder: (_) =>MainCase(user.user!.uid)));
            return alert;
           
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New Story App"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 60.0, bottom: 180.0, left: 120.0, right: 120.0),
            child: SizedBox(
              width: 845,
              height: 300,
              child: Card(
                // color: Colors.amberAccent,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 120.0,

                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(
                            top: 15.0, right: 40.0, left: 40.0, bottom: 10.0),
                        child: Column(
                          children: [
                            const Text(
                              "Login User",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 35.0,
                                  fontFamily: 'Merriweather'),
                            ),
                            const SizedBox(height: 21.0),

                            //InputField Widget from the widgets folder
                            // LayoutBuilder(
                            //   builder: (BuildContext context,
                            //       BoxConstraints constraints) {
                            //     return
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  child: const Text(
                                    "Enter Email",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 4.7,
                                  color: Colors.blue[50],
                                  child: TextField(
                                    controller: useremailController,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      // contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      hintText: "content",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //   },
                            // ),
                            //   label: "Username",
                            //   content: "a_khanooo"
                            // ),

                            const SizedBox(height: 20.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  child: const Text(
                                    "Enter Password",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40.0,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 4.7,
                                  color: Colors.blue[50],
                                  child: TextField(
                                    controller: userpasswordController,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      hintText: "Enter Password",
                                      fillColor: Colors.blue[50],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //Gender Widget from the widgets folder
                            // Gender(),

                            const SizedBox(height: 20.0),

                            //InputField Widget from the widgets folder
                            // InputField(
                            //   label: "Date of birth",
                            //   content: "03/04/2000"
                            // ),

                            //InputField Widget from the widgets folder
                            // InputField(
                            //   label: "Email",
                            //   content: "anything@site.com"
                            // ),

                            //Membership Widget from the widgets folder

                            Row(
                              children: <Widget>[
                                const SizedBox(
                                  width: 170.0,
                                ),
                                FlatButton(
                                  color: Colors.grey[200],
                                  onPressed:(){
                                      Navigator.pushNamed(context,'/');
                                  },
                                  child: Text("Cancel"),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                FlatButton(
                                  color: Colors.lightBlue,
                                  onPressed: login,
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 4.19,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.lightBlue[600],
                        child: Padding(
                          padding: const EdgeInsets.only(),
                          child: Align(
                            // alignment: Alignment.centerRight,
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 60.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: const Text(
                                      "Let's get you set up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 5.0, bottom: 5.0),
                                    child: const Text(
                                      "Login And Go For Main Page",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class Model{
  // {address: hyd, name: Asad, email: zubair@gmail.com, uid: woEIcxDMEQd2gL4CuLDcPkQTHF62, password:
// 123456}
  String email,name,uid,address,password;
  Model(this.email,this.name,this.uid,this.address,this.password);
}
