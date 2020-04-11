import 'package:de_laatste_hap/provider/verlanglijst.dart';
import 'package:flutter/foundation.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

class TafelState with ChangeNotifier{

List<String> _rawTafelList = ["tafel data laden..."];

List<String> get rawTafelList => _rawTafelList;

  void loadPosibleTafel ()async{
 print("get posible tafels");
      Firestore.instance
    .collection('possibleTables')
    .document("tableList")
    .snapshots()
    .listen((data) {
      List<dynamic> tafels = data.data["list"];
      print(tafels);
      _rawTafelList = [];
      for(int i =0; i < tafels.length;i++){
        _rawTafelList.add(tafels[i]);
        // print(tafels[i]+" => "+ _rawTafelList[i]);
      }
      print("raw tafel list: "+ rawTafelList.toString());
      notifyListeners();
    });
    
    
  }



}