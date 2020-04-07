import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginState with ChangeNotifier{

  String _userID;

  String get userID => _userID;
final FirebaseAuth _auth = FirebaseAuth.instance;


  LoginState(){
    _auth.currentUser().then((value){
      
      if(value == null){
        
        _userID = null;
        
        notifyListeners();
      }else{
        
        _userID = value.uid;
       
        notifyListeners();
      }
      

    });
  }

  void startApp(){
    startByTimeOut(5);
  }

  Future startByTimeOut(int sec) {
   Future.delayed(Duration(seconds: sec), () {
    
    notifyListeners();
    
   });
   return null;
  }
  Future resterErr(int sec) {
   Future.delayed(Duration(seconds: sec), () {
    
    notifyListeners();
    
   });
   return null;
  }



 void loginByEmail(String email, String password){
    _auth.signInWithEmailAndPassword(
      email: email,
      password: password
      ).then((v){
        _userID = v.user.uid;
        
        print(_userID);
        notifyListeners();
      }).catchError((err){
        print (err);
        
        notifyListeners();
        resterErr(3);
      });
      
   
  }
  void registerByEmail(String email, String password) {
    _auth.createUserWithEmailAndPassword(email: email, password: password)
    .then((v){
      try{
        v.user.sendEmailVerification();
        print("email send");
      }catch(err){
        print (err);
      }
      _userID = v.user.uid;
     
      print(_userID);
      
      notifyListeners();
    }).catchError((err){
      print(err);
      
      notifyListeners();
      resterErr(3);
    });
    
  }

  void logout(){
    _auth.signOut();
      _userID = null;
    notifyListeners();
    
  }






}