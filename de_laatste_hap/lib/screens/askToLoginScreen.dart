import 'package:flutter/material.dart';
import 'login.dart';


class AskToLoginScreen extends StatelessWidget {
    AskToLoginScreen(this._text);
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Container( 
      width: MediaQuery.of(context).size.width,
      child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(_text,style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600
          ),),


          SizedBox(height: 20,),


          RaisedButton(child: Text("login",style: TextStyle(
            color: Colors.white
          ),),
          onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          color: Color(0xFFBE0029),
          ),


          ],));
  }
}