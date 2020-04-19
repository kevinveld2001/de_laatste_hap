import 'package:flutter/material.dart';
import 'askToLoginScreen.dart';

import '../provider/login.dart';
import 'package:provider/provider.dart';
import '../provider/verlanglijst.dart';
import '../provider/getProducts.dart';
import '../provider/adminCheck.dart';


import '../widgets/productCard.dart';

class Verlanglijst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    return loginState.userID ==null? AskToLoginScreen("login om je verlanglijst te zien."):
    VelanglijstScreen();
  }
}

class VelanglijstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    var getProducts = Provider.of<GetProducts>(context);
    var wishListState = Provider.of<WishListState>(context);
    var adminCheckState = Provider.of<AdminCheck>(context);

    if(wishListState.wishList.length == 0){
      wishListState.loadWishList(loginState.userID,getProducts.productList);
    }
    return Container(
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
                        adminCheckState.logout();
                        wishListState.clearList();
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                        Text("Verlanglijst van: ",style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600
                        ),),

                          SizedBox(height: 20,),

                          Text(loginState.email,style: TextStyle(
                            fontSize: 15,
                          ),),
                          SizedBox(height: 20,),
                     
                          for(int i=0; i < wishListState.wishList.length; i++)
                        ProductCard(
                        wishListState.wishList[i].url,
                        wishListState.wishList[i].name,
                        wishListState.wishList[i].prijs,
                        i,
                         true,),


                    ],),),
                  ],
                )
              )



          ],
        ));
  }
}