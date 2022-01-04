import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  var squares;
  late bool isXNext;
  late bool isWon;
  void _initialize() {
    setState(() {
      squares = List.filled(9, '');
      isXNext = true;
      isWon = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 65, 27, 1.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isWon
                ? Text("Winner is ${isXNext ? 'Y' : 'X'}")
                : Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white)),
                    child: Text(
                      "Next Player is  : ${isXNext ? ' Player 1' : 'Y'}",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [makeSquare(0), makeSquare(1), makeSquare(2)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [makeSquare(3), makeSquare(4), makeSquare(5)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [makeSquare(6), makeSquare(7), makeSquare(8)],
            )
          ],
        ),
      ),
    );
  }

  markSqaure(int number) {
    setState(() {
      squares[number] = isXNext ? 'X' : 'O';
      isXNext = !isXNext;
    });
    if (checkWinner()) {
      setState(() {
        isWon = true;
      });
      showAlert("Winner is  ${isXNext ? 'Y' : 'X'} ");
    } else {
      if (!squares.contains('')) {
        showAlert("Its a Draw");
      }
    }
  }

  showAlert(String msg) {
    return showDialog(
        context: context,
        builder: (ctxt) => AlertDialog(
              backgroundColor: Colors.black,
              title: Text(
                "Alert",
                style: TextStyle(color: Colors.white),
              ),
              content: Text(
                msg,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      _initialize();
                      Navigator.pop(ctxt);
                    },
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ));
  }

  bool checkWinner() {
    var lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var i in lines) {
      int a = i[0];
      int b = i[1];
      int c = i[2];

      if (squares[a] != '' &&
          squares[a] == squares[b] &&
          squares[a] == squares[c]) {
        return true;
      }
    }
    return false;
  }

  makeSquare(int number) {
    return SizedBox(
      height: 75,
      width: 75,
      child: InkWell(
        onTap: () {
          if (squares[number] == '' && !isWon) {
            markSqaure(number);
          }
        },
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.green)],
              border: Border.all(color: Colors.white, width: 10)),
          child: Center(
            child: Text(
              "${squares[number]}",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}