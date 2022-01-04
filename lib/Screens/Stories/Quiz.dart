// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:newapp_video_app/Screens/Stories/Result.dart';

class QuizTime extends StatefulWidget {
  var value;
  var userUid;

  QuizTime(this.value,this.userUid);

  @override
  _QuizTimeState createState() => _QuizTimeState(value,userUid);
}

class _QuizTimeState extends State<QuizTime> {
  var value;
  var userUid;

  _QuizTimeState(this.value,this.userUid);

  List qList = [];
  var counter = 0;
  var score=0;

  @override
  initState() {
    super.initState();
    // _ge   tUserName();
    //   print(value.title);
    // print(value.content);
    print("User Uid : ${userUid} ");
    print("Url :${value[0]}");
    print("Uid : ${value.length}");

    var obj = {
      "Question": value[0].q_1,
      "Option 1": value[0].op_1_1,
      "Option 2": value[0].op_1_2,
      "Option 3": value[0].op_1_3,
      "Correct_Answer": value[0].correct_1,
    };
    var obj1 = {
      "Question": value[0].q_2,
      "Option 1": value[0].op_2_1,
      "Option 2": value[0].op_2_2,
      "Option 3": value[0].op_2_3,
       "Correct_Answer": value[0].correct_2,

    };

    qList.add(obj);
    qList.add(obj1);

    // url=value.Video_Url;
    print(qList);
  }

   checkWin(String UserAns,BuildContext context){
    //  print(UserAns);
    
    if(UserAns==qList[counter]["Correct_Answer"]){
      print("Correct");
       score= score+5;
       final snackbar = SnackBar(
      duration: Duration(milliseconds : 500),
      backgroundColor: Colors.green,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Correct!"),
      ),);
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackbar);
    }
    else{
      print("InCorrect");
      final snackbar = SnackBar(
      duration: Duration(milliseconds : 500),
      backgroundColor: Colors.red,
      content: Text("Incorrect!"),
      );
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackbar);
    }
  
  if(counter==1){
       Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ResultCard(userUid=userUid,score=score)));
     
   }
     setState(() {

 
   if(counter<1)
   {
     counter = counter +1;
   }
  
   
 
    
  });


   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Quiz Time")),
        ),
        body:  Builder(
              builder : (BuildContext context) => Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 30),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Color(0xFFF7C229))),
                        height: 90.0,
                        width: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FittedBox(
                              child: Text(
                                  "Question ${counter+1})  " + qList[counter]["Question"],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              checkWin( qList[counter]["Option 1"],context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[300],
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            child: Text(
                              qList[counter]["Option 1"],
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                             checkWin( qList[counter]["Option 2"],context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[300],
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            child: Text(
                              qList[counter]["Option 2"],
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              checkWin( qList[counter]["Option 3"],context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[300],
                                side: BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            child: Text(
                              qList[counter]["Option 3"],
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        ) 
    );
  }
}
