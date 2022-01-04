// ignore: file_names
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Stories/Detail_Stories.dart';
import 'package:flutter/rendering.dart';

class MainCase extends StatefulWidget {
var userUid;

MainCase(this.userUid);

  @override
  _MainCaseState createState() => _MainCaseState(userUid);
}

class _MainCaseState extends State<MainCase> {

  var userUid;
  _MainCaseState(this.userUid);
  @override
  void initState() {
    super.initState();
    //  _getUserName();
    print("uid"+userUid);
  }

  @override

  var value;

  List<Model> list = [];

  String Username = "";

  Future<List<dynamic>> _getUserName() async {
    //       final DocumentReference document =   FirebaseFirestore.instance.collection("listofprods").doc('ac1');

    //       await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
    //          print(snapshot.data());
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

//        var collection = FirebaseFirestore.instance.collection('Stories');
// var querySnapshot = await collection.get();
// for (var queryDocumentSnapshot in querySnapshot.docs) {
//   Map<String, dynamic> data = queryDocumentSnapshot.data();
//   print("Dtaa :$data");
// }

List id =[];
var collection = FirebaseFirestore.instance.collection('Stories');
var querySnapshots = await collection.get();
for (var snapshot in querySnapshots.docs) {
  var documentID = snapshot.id; // <-- Document ID
  print("Id : ${documentID}");
  id.add(documentID);
}
print(id);


    var data = await FirebaseFirestore.instance.collection("Stories").get();
    // var p = data.docs;
    // print("Data :${p.id}");

    for (int i = 0; i < data.docs.length; i++) {
      Model model = Model(
          data.docs[i].data()['Story'],
          data.docs[i].data()['Video_Url'],
          id[i],
          data.docs[i].data()['question_1'],
          data.docs[i].data()['question_2']);
      print( data);
      list.add(model);
    }
    //  Navigator.pushNamed(context,'/Main_User');
    print(list);

    return list;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:
            AppBar(title: const Text("Welcome In Story App"), actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      // Text(Username),
                      Padding(
                          padding: const EdgeInsets.only(right: 20.0, left: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.more_vert),
                          )),
                    ],
                  )))
        ]),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "All Stories",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 28,
                ),
              ),
              FutureBuilder<List<dynamic>>(
                future: _getUserName(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 2,
                      controller: ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      childAspectRatio: (1 / .25),
                      children: List.generate(snapshot.data.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => HomePage(
                                 value = snapshot.data[index],
                                 userUid=userUid,

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
                                      leading:
                                          const Icon(Icons.album, size: 50),
                                      title: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: Text(
                                            '${snapshot.data[index].Story}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 25),
                                          ),
                                        ),
                                      ),
                                      // subtitle: Text('TWICE'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget MyUI(
    String title,
    String url,
  ) {
    return Container(
      child: Column(
        children: [Text(title), Text(url)],
      ),
    );
  }
}

class Model {
  // {address: hyd, name: Asad, email: zubair@gmail.com, uid: woEIcxDMEQd2gL4CuLDcPkQTHF62, password:
// 123456}
  String Story, Video_Url, uid, q_1, q_2;
  Model(this.Story, this.Video_Url, this.uid, this.q_1, this.q_2);
}
