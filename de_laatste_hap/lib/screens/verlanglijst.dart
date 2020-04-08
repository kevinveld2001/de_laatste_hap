import 'package:flutter/material.dart';
import 'askToLoginScreen.dart';

import '../provider/login.dart';
import 'package:provider/provider.dart';



class Verlanglijst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    return loginState.userID ==null? AskToLoginScreen("login om je verlanglijst te zien."):
    VelanglijstScreen();
  }
}

class VelanglijstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    return Container(
      color: Color(0xFFBE0029),
      child:Column(
      
          children: <Widget>[
            Container(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //backbutton
                   
                    

                    Text("de laatste hap",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      letterSpacing: 5.0
                    ),),
                   
                  ],
                ),
              ),
              Container(
                
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - (90+56),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0),
                  )
                ),
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text("Verlanglijst van: ",style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600
                        ),),

                          SizedBox(height: 20,),

                          Text(loginState.email,style: TextStyle(
                            fontSize: 15,
                          ),),
                          RaisedButton(onPressed: (){

                            loginState.logout();

                          }, child:Text("uitloggen"))
                        
                     



                    ],),),
                  ],
                )
              )



          ],
        ));
  }
}