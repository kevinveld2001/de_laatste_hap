import 'package:flutter/material.dart';
import '../provider/getreserveringen.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var reserveringenListState = Provider.of<GetReserveringen>(context);
  if(reserveringenListState.reservationList.length == 0 ){
    reserveringenListState.loadData();
  }
  
    return Text("admin Page");
  }
}