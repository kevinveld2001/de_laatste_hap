import 'package:de_laatste_hap/widgets/adminPageCard.dart';
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


                    Text("de laatste hap",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      letterSpacing: 5.0
                    ),),
                    
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
                  padding: EdgeInsets.all(40),
                  children: <Widget>[

              for(int i=0;i<reserveringenListState.reservationList.length;i++)
                 Column(
                   children: <Widget>[
                     AdminPageCard(
                     reserveringenListState.reservationList[i].voornaam +" "+ 
                     reserveringenListState.reservationList[i].achternaam,
                     reserveringenListState.reservationList[i].tafel,
                     reserveringenListState.reservationList[i].tijd,
                     reserveringenListState.reservationList[i].date),
                     SizedBox(height: 20,)
                   ],
                 ),

                ],)

              
              )



          ],
        ),
      ),
    );
  }
}