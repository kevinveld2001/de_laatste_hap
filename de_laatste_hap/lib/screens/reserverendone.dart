import 'package:flutter/material.dart';


class ReserverendoneScreen extends StatelessWidget {
  ReserverendoneScreen(this.firstname,this.lastname,this.tafel,this.date);
  final String firstname;
  final String lastname;
  final DateTime date;
  final String tafel; 
  List<String> maandenLijst = ["januari","februari","maart","april","mei","juni","juli","augustus","september","oktober","november","december"];
  @override
  Widget build(BuildContext context) {
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
                  Icon(Icons.done,size: 50,),
                  SizedBox(height: 20,),
                  Text("resevering geplaatst"),
                  Text("voornaam: $firstname"),
                  Text("achternaam: $lastname"),
                  Text("tafel: $tafel"),
                  Text("tafel: ${date.day} ${maandenLijst[date.month-1]} ${date.year}"),

                ],),
              ),

              ),])));
  }
}