

import 'package:flutter/material.dart';
import 'askToLoginScreen.dart';


import '../provider/login.dart';
import 'package:provider/provider.dart';

class Reserveren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    return loginState.userID ==null? 
    AskToLoginScreen("login om te kunnen reserveren"):
    Text("logidedin");
    
  }
}