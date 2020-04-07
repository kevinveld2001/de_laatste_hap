import 'package:flutter/material.dart';
import 'askToLoginScreen.dart';

import '../provider/login.dart';
import 'package:provider/provider.dart';

class Verlanglijst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    return loginState.userID ==null? AskToLoginScreen("login om je verlanglijst te zien."):
    Text("loged in");
  }
}