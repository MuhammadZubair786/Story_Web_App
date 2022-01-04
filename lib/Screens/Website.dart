import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:newapp_video_app/Screens/Card.dart';
import 'package:newapp_video_app/Screens/Slider.dart';

double collapsableHeight = 0.0;
Color selected = Color(0xffffffff);
Color notSelected = Color(0xafffffff);

class WebsitePage extends StatefulWidget {
  @override
  _WebsitePageState createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            AnimatedContainer(
              margin: EdgeInsets.only(top: 79.0),
              duration: Duration(milliseconds: 375),
              curve: Curves.ease,
              height: (width < 800.0) ? collapsableHeight : 0.0,
              width: double.infinity,
              color: Color(0xff121212),
              child: SingleChildScrollView(
                child: Column(
                  children: navBarItems,
                ),
              ),
            ),
            Container(
              color: Colors.lightBlue,
              height: 60.0,
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "NavBar",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Color(0xffffffff),
                    ),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    if (width < 800.0) {
                      return NavBarButton(
                        onPressed: () {
                          if (collapsableHeight == 0.0) {
                            setState(() {
                              collapsableHeight = 240.0;
                            });
                          } else if (collapsableHeight == 240.0) {
                            setState(() {
                              collapsableHeight = 0.0;
                            });
                          }
                        },
                      );
                    } else {
                      return Row(
                        children: navBarItems,
                      );
                    }
                  })
                ],
              ),
            ),
            // Center(child: Text("Hello")),
            Container(
              margin: EdgeInsets.only(top: 0),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  children: [
                    SliderPage(),
                    Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: Text("Servicers",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: new EdgeInsets.all(32.0),
                      child: new Center(
                        child: new Row(
                          children: <Widget>[
                            new Card(
                             color: Colors.lightBlue,
                                margin: EdgeInsets.only(right: 20),

                              child: new Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 400,
                                height: 300,
                                padding: new EdgeInsets.all(32.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Text('Hello World',style: TextStyle(color: Colors.white,)),
                                    new Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',style: TextStyle(color: Colors.white,))
                                  ],
                                ),
                              ),
                            ),
                            new Card(
                                margin: EdgeInsets.only(right: 20),
                               color: Colors.lightBlue,
                              child: new Container(
                                margin: EdgeInsets.only(right: 20),

                                width: 400,
                                height: 300,
                                padding: new EdgeInsets.all(32.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Text('Hello World',style: TextStyle(color: Colors.white,)),
                                    new Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',style: TextStyle(color: Colors.white,))
                                  ],
                                ),
                              ),
                            ),
                            new Card(
                               color: Colors.lightBlue,
                              child: new Container(
                                width: 400,
                                height: 300,
                                padding: new EdgeInsets.all(32.0),
                                child: new Column(
                                  children: <Widget>[
                                    new Text('Hello World',style: TextStyle(color: Colors.white,)),
                                    new Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'
                                    ,style: TextStyle(color: Colors.white,)
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: Text("Contact",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    ),
                    new Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: new EdgeInsets.all(32.0),
                      child: new Center(
                        child: new Row(
                          children: <Widget>[
                             new Card(
                               color: Colors.lightBlue,
                              child: new Container(
                                width: 400,
                                height: 60,
                               
                                child: new Column(
                                  children: <Widget>[
                                    new Text('Email'),
                                    new Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. ')
                                  ],
                                ),
                              ),
                            ),
                             new Card(
                               color: Colors.lightBlue,
                              child: new Container(
                                width: 400,
                                height: 60,
                               
                                child: new Column(
                                  children: <Widget>[
                                    new Text('Education Page'),
                                    new Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. ')
                                  ],
                                ),
                              ),
                            ),
                            new Card(
                               color: Colors.lightBlue,
                              child: new Container(
                                width: 400,
                                height: 60,
                               
                                child: new Column(
                                  children: <Widget>[
                                    new Text('Education Youtube Channel'),
                                    new Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. ')
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: Container(
                            width:MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.blue,
                            child:Center(child: Text("Footer",style: TextStyle(color: Colors.white,fontSize: 30),))
                          ),
                        )
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarButton extends StatefulWidget {
  final Function onPressed;

  NavBarButton({
    required this.onPressed,
  });

  @override
  _NavBarButtonState createState() => _NavBarButtonState();
}

class _NavBarButtonState extends State<NavBarButton> {
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: 60.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xcfffffff),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          splashColor: Colors.white60,
          onTap: () {
            setState(() {
              widget.onPressed();
            });
          },
          child: Icon(
            Icons.menu,
            size: 30.0,
            color: Color(0xcfffffff),
          ),
        ),
      ),
    );
  }
}

List<Widget> navBarItems = [
  NavBarItem(
    text: 'Home',
  ),
  NavBarItem(
    text: 'Search',
  ),
  NavBarItem(
    text: 'Contact',
  ),
  NavBarItem(
    text: 'About',
  ),
  NavBarItem(
    text: 'Login',
  ),
];

class NavBarItem extends StatefulWidget {
  final String text;

  NavBarItem({
    required this.text,
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  Color color = notSelected;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (value) {
        setState(() {
          color = selected;
        });
      },
      onExit: (value) {
        setState(() {
          color = notSelected;
        });
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.red,
          onTap: () {
            if (widget.text == "Hello") {
              Navigator.pushNamed(context, '/Main_User');
            } else if (widget.text == "Login") {
              Navigator.pushNamed(context, '/home');
            } else {
              print("Not Defined");
            }
          },
          child: Container(
            height: 60.0,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
