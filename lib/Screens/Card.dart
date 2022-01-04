import 'package:flutter/material.dart';

class CardData extends StatefulWidget {
  const CardData({ Key? key }) : super(key: key);

  @override
  _CardDataState createState() => _CardDataState();
}

class _CardDataState extends State<CardData> {
  @override
  Widget build(BuildContext context) {
    return Card(  
    child : ListTile(  
          leading: Icon(Icons.album, size: 45),  
          title: Text('Sonu Nigam'),  
          subtitle: Text('Best of Sonu Nigam Song'),  
        ),  
        
    );
  }
}