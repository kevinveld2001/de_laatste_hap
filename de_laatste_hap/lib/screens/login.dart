import 'package:flutter/material.dart';

import '../provider/login.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";


  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);

    print("userID: ${loginState.userID}");
    if(loginState.userID != null){
      Navigator.pop(context);
    }
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFFBE0029),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //backbutton
                    IconButton(icon: Icon(Icons.navigate_before,color: Colors.white,size: 25,),
                    onPressed: (){
                      print("i want back");
                      Navigator.pop(context);
                    },),
                    

                    Text("de laatste hap",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      letterSpacing: 5.0
                    ),),
                    SizedBox(width: 25,)
                  ],
                ),
              ),
              Container(
                
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.0),
                    topRight: Radius.circular(36.0),
                  )
                ),
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(children: <Widget>[
                    Text("ログインする",style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700
                    ),),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 40,),
                            TextFormField(
                            decoration: InputDecoration(
                              hintText: "email",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'enter your email';
                              }
                              _email = value;
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                           TextFormField(
                             obscureText: true,
                            decoration: InputDecoration(
                              
                              hintText: "password",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'enter your password';
                              }
                              if(value.length <6){
                                return 'password not long enough';
                              }
                              _password = value;
                              return null;
                            },
                          ),
                          SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                            RaisedButton(child: Text("login",style: TextStyle(
                              color: Colors.white
                            ),),
                            onPressed: (){
                                
                              if (_formKey.currentState.validate()) {
                                loginState.loginByEmail(_email, _password);
                              }
                            },
                            color: Color(0xFFBE0029),
                            ),
                            FlatButton(onPressed: (){
                              
                              Navigator.pop(context);
                            }, child: Text("annuleren"))
                          ],)
                           
                        ]

                    )
                    )


                  ],),
                ),
              )



          ],
        ),
      ),
    );
  }
}