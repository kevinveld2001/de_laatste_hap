import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AdminCheck with ChangeNotifier{



  bool _isAdmin = false;
  String _checkedID;

  bool get isAdmin => _isAdmin; 
  String get checkedID => _checkedID;


  Future<void> checkIfIamAdmin (String userID)async{

await new Future.delayed(const Duration(milliseconds: 400),(){
_checkedID = userID;
  try{
    Firestore.instance
    .collection('roles')
    .document(userID)
    .get()
    .then((DocumentSnapshot ds){
      
      if(ds.data["role"] == "admin"){
        print("this user is a admin");
        _isAdmin = true;
      }else {
        _isAdmin = false;
      }
      notifyListeners();
    });
  }catch(err){
    var errorhold = err;
    _isAdmin = false;
    notifyListeners();
  }
  
});
    
  }


  void logout(){
    _isAdmin = false;
    notifyListeners();
  }



}