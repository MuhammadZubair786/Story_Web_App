import 'package:flutter/material.dart';

class admin_Dashboard extends StatefulWidget {
  const admin_Dashboard({Key? key}) : super(key: key);

  @override
  _admin_DashboardState createState() => _admin_DashboardState();
}

class _admin_DashboardState extends State<admin_Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text("New Story App"),
          ),
          drawer: BuildDrawer(),
          body:  Column(
            children:const  [
              SizedBox(
                height: 40,),
              Center(child: SizedBox(
                height: 40,
                child: Text("Welcome In Admin Panel ",style: TextStyle(fontSize: 30,color: Colors.purple),))),

            ],
          ),
        ));
  }

  Drawer BuildDrawer() {
    return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child:  Container(
                width: 300.0,
                height: 500.0,
                decoration: BoxDecoration(
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
                      children:const [
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
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        '/Add_Stories');
                    },
                    child: ListTile(
                        leading: IconButton(
                          icon: Icon((Icons.home)),
                          color: Colors.red,
                          iconSize: 30,
                          onPressed:(){ Navigator.pushNamed(context, '/Add_Stories');},
                        ),
                        title:const Text("Add New Storie")),
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
