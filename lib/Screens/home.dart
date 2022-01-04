import 'package:flutter/material.dart';
import 'package:newapp_video_app/Screens/login_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final TextEditingController username = TextEditingController();
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();
    final TextEditingController addresscontroller = TextEditingController();

    final TextEditingController adminkeyController = TextEditingController();
    adminkeyController.text='12345';

    void createAccount() async {
      String name = username.text;
      String email = emailcontroller.text;
      String password = passwordcontroller.text;
      String address = addresscontroller.text;
      // print(name+email+password+address);

      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email.toString().trim(),
            password: password.toString().trim());

        var obj = {
          "name": name,
          "email": email,
          "password": password,
          "address": address,
          "uid": user.user!.uid
        };
        await db.collection('users').doc(user.user!.uid).set(obj);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                content: Text("Registered Successfully! You Can now Login"),
              );
            });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Text("The password provided is too weak"),
                );
              });
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Text("The account already exists for that email"),
                );
              });
        }

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const AlertDialog(
                content: Text("Registered Successfully! You Can now Login"),
              );
            });

        print('User is now registered');
      } catch (e) {
        print('Error');
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("$e"),
              );
            });
      }
    }

    chk() {
      String adminkey = adminkeyController.text;
      Navigator.pop(context, true);
      print(adminkey);
      if (adminkey == '12345') {
        print("Admin");
        Navigator.pushNamed(context, '/Admin');
      } else {
        print("Not Admin");
        Widget okButtons = TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context, true);
            });
        AlertDialog alerts = AlertDialog(
          title: const Center(child: Text("Enter Correct Admin Key")),
          // content: TextField(
          //   controller: adminkeyController,
          // ),
          actions: [
            okButtons,
          ],
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alerts;
          },
        );
      }
    }

    void adminchk() {
      // print("wait");
      Widget okButtons = TextButton(child: const Text("OK"), onPressed: chk);
      AlertDialog alerts = AlertDialog(
        title: const Center(child: Text("Enter Admin Key")),
        content: TextField(
          controller: adminkeyController,
        ),
        actions: [
          okButtons,
        ],
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerts;
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("New Story App"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
          child: SizedBox(
            width: 1050,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0)),
              elevation: 120.0,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 4.0,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.lightBlue[600],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 50.0, left: 50.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 60.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
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
                                height: 40.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 5.0, bottom: 5.0),
                                child: const Text(
                                  "'' It should only take a couple of minutes to create your account ''",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => login_User()));
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    textStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                onPressed: adminchk,
                                child: const Text(
                                  "Open Admin Panel",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    textStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 40.0, left: 40.0, bottom: 10.0),
                      child: Column(
                        children: [
                          const Text(
                            "Sign Up",
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
                                width: 150.0,
                                child: const Text(
                                  "Enter User Name",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                color: Colors.blue[50],
                                child: TextField(
                                  controller: username,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
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
                                width: 150.0,
                                child: const Text(
                                  "Enter User Email",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                color: Colors.blue[50],
                                child: TextField(
                                  controller: emailcontroller,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    hintText: "content",
                                    fillColor: Colors.blue[50],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //Gender Widget from the widgets folder
                          // Gender(),

                          const SizedBox(height: 20.0),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: const Text(
                                  "Enter User Password",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                color: Colors.blue[50],
                                child: TextField(
                                  controller: passwordcontroller,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    hintText: "content",
                                    fillColor: Colors.blue[50],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //InputField Widget from the widgets folder
                          // InputField(
                          //   label: "Date of birth",
                          //   content: "03/04/2000"
                          // ),

                          const SizedBox(height: 20.0),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: const Text(
                                  "Enter User Address",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.lightBlue),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 4,
                                color: Colors.blue[50],
                                child: TextField(
                                  controller: addresscontroller,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    hintText: "content",
                                    fillColor: Colors.blue[50],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //InputField Widget from the widgets folder
                          // InputField(
                          //   label: "Email",
                          //   content: "anything@site.com"
                          // ),

                          const SizedBox(height: 20.0),

                          const SizedBox(height: 20.0),

                          //Membership Widget from the widgets folder

                          const SizedBox(
                            height: 40.0,
                          ),

                          Row(
                            children: <Widget>[
                              const SizedBox(
                                width: 170.0,
                              ),
                              FlatButton(
                                color: Colors.grey[200],
                                onPressed: () {},
                                child: Text("Cancel"),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              Container(
                                color: Colors.red,
                                child: ElevatedButton(
                                  onPressed: createAccount,
                                  child: Text(
                                    "Create Account",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
