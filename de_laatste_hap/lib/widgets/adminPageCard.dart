import 'package:flutter/material.dart';


class AdminPageCard extends StatelessWidget {
  AdminPageCard(this._name,this._tafel,this._tijd);
 
  final String _name;
  final String _tafel;
  final int _tijd;
  @override
  Widget build(BuildContext context) {
    return Card(child: Container(
      
      height: 100,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Text(_name,style: TextStyle(
              fontSize: 20
            ),),
            Text(_tijd.toString()+":00",style: TextStyle(
              fontSize: 15
            ),)
          ],),
          Row(children: <Widget>[
            Text(_tafel,style: TextStyle(
              fontSize: 15
            ),),
          ],)
        ],),
      ),
    ),);
  }
}