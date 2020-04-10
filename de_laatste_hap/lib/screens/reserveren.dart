

import 'package:flutter/material.dart';
import 'askToLoginScreen.dart';


import '../provider/login.dart';
import 'package:provider/provider.dart';
import '../provider/verlanglijst.dart';
import '../provider/getProducts.dart';

class Reserveren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    return loginState.userID ==null? 
    AskToLoginScreen("login om te kunnen reserveren"):
    ReserverenScreen();
    
  }
}

List<String> maandenLijst = ["januari","februari","maart","april","mei","juni","juli","augustus","september","oktober","november","december"];
String dropdownValue;
String tafelValue;


String firstname;
String lastname;
DateTime datum;
int uur;
String tavel;
String email;
String userID;

class ReserverenScreen extends StatefulWidget {

//date picker 
  @override
  _ReserverenScreenState createState() => _ReserverenScreenState();
}

class _ReserverenScreenState extends State<ReserverenScreen> {
Future<DateTime> datePicker(BuildContext context){
  
 return showDatePicker(
  context: context,
  initialDate: datum==null?DateTime.now():datum,
  firstDate: DateTime(DateTime.now().year,DateTime.now().month, DateTime.now().day ,DateTime.now().day -1),
  lastDate: DateTime(DateTime.now().year + 2),
  );
} 

  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    
   

    userID = loginState.userID;
    email = loginState.email;

    return  SingleChildScrollView(
          child: Container(
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
                     
                      SizedBox(width: 20,),

                      Text("de laatste hap",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        letterSpacing: 5.0
                      ),),
                      IconButton(
                        icon: Icon(Icons.exit_to_app,color: Colors.white,),
                        onPressed: (){
                          loginState.logout();
                        },
                      )
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
                        child: Form(
                                
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                           
                              TextField(
                                cursorColor:Color(0xFFBE0029),
                                onChanged: (v){
                                  firstname = v;
                                },
                                decoration: InputDecoration(
                                  hintText: "voornaam"
                                  
                                  ),
                              ),
                              SizedBox(height: 20,),
                              TextField(
                                cursorColor:Color(0xFFBE0029),
                                onChanged: (v){
                                  lastname = v;
                                },
                                decoration: InputDecoration(
                                  hintText: "achternaam"
                                  
                                  ),
                              ),
                              SizedBox(height: 20,),
                              TextField(
                                enableInteractiveSelection: false,
                                focusNode: AlwaysDisabledFocusNode(),
                                onTap: ()async{
                                  FocusScope.of(context).requestFocus(new FocusNode()); //remove focus

                                  print("date input");
                                  DateTime nu = DateTime.now();
                                  DateTime pickeddate = await datePicker(context);
                                  print(pickeddate.toString());
                                  if(pickeddate != nu){
                                    setState(() {
                                      datum = pickeddate;

                                    });
                                  
                                  }
                                  // print(DateTime(pickeddate.year,pickeddate.month,pickeddate.day, 12).toString());
                                },
                                decoration: InputDecoration(
                                  hintText: datum == null?"datum": 
                                  datum.day.toString() +" "+ maandenLijst[datum.month-1] +" "+ datum.year.toString(),
                                  
                                  ),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  DropdownButton<String>(
                                    hint: Text("datum"),

                                  value: dropdownValue,
                                  icon: Icon(Icons.timer),
                                  iconSize: 24,
                                  elevation: 16,
                           
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (String newValue) {

                                    List<String> timelist = ['12:00', '13:00', '14:00', '15:00',"16:00","17:00","18:00","19:00","20:00","21:00","22:00"];
                                    for(int i = 0 ;i < timelist.length;i++){
                                      if(newValue == timelist[i]){
                                        uur = i + 12;
                                        print(uur.toString()+" uur");
                                      }
                                    }


                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>['12:00', '13:00', '14:00', '15:00',"16:00","17:00","18:00","19:00","20:00","21:00","22:00"]
                                    .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    })
                                    .toList(),
                            ),

                              DropdownButton<String>(
                                    hint: Text("tafel"),

                                  value: tafelValue,
                                  icon: Icon(Icons.add_location),
                                  iconSize: 24,
                                  elevation: 16,
                           
                                  underline: Container(
                                    height: 2,
                                    color: Colors.grey,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      tafelValue = newValue;
                                    });
                                  },
                                  
                                  items: <String>['tafel 4 - 2 personen', '13:00', '14:00', '15:00',"16:00","17:00","18:00","19:00","20:00","21:00","22:00"]
                                    .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    })
                                    .toList(),
                            ),

                                ],
                              ),
                              SizedBox(height: 20,),

                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: (){},
                              color: Color(0xFFBE0029),
                              child: Text("Resevering plaatsen",style: TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                          )

                      ],),
                        ),),
                    ],
                  )
                )



            ],
          )),
    );
  }
}


class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}