
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'reservatie.dart';

class GetReserveringen with ChangeNotifier{

List<Reservatie> _reservationList = [];
List<String> _maandenLijst = ["jan","feb","mrt","apr","mei","jun","jul","aug","sep","okt","nov","dec"];

List<Reservatie> get reservationList => _reservationList;
void loadData(){

DateTime _nu = DateTime.now();
_nu = DateTime(_nu.year,_nu.month,_nu.day,_nu.hour-1);

Firestore.instance
    .collection('reseveringen')
    .where("datum", isGreaterThan: _nu)
    .orderBy("datum")
    .snapshots()
    .listen((data) {
      _reservationList = [];
        data.documents.forEach((doc) {
          
          
          int datum = int.parse(doc.data["datum"].seconds.toString());
          int tijd = new DateTime.fromMillisecondsSinceEpoch(datum * 1000).hour;
          String date = new DateTime.fromMillisecondsSinceEpoch(datum * 1000).day.toString()+
          " "+ _maandenLijst[ DateTime.fromMillisecondsSinceEpoch(datum * 1000).month];
          
          _reservationList.add(Reservatie(
            doc.data["voornaam"],
            doc.data["achternaam"],
            doc.data["tafel"],
            tijd,
            date
          ));

        });
        notifyListeners();
        });


}




}
