import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/getProducts.dart';
import '../provider/verlanglijst.dart';
import '../provider/login.dart';


class ProductInfo extends StatefulWidget {
   ProductInfo(this.index,this.fromWhishList);
  final int index;
  final bool fromWhishList;
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
    
// create an instance variable
var _controller = ScrollController(); 
var _controller2 = ScrollController(); 


@override
void initState() {
  super.initState();
  // set up listener here
  _controller.addListener(() {
    
    setState(() {
          _chckSwitch = true;
          _chckSwitch2 = false;
          
        });
        
    if (_controller.position.atEdge ) {
      if (_controller.position.pixels != 0){
        // you are at bottom position
        print("i am at the bottom");
        setState(() {
          _chckSwitch = false;
          _chckSwitch2 = false;
          print("switch: "+_chckSwitch.toString());
          _controller2.animateTo(5.0, duration: Duration(milliseconds: 300), curve: Curves.linear);
        });
        
      }


    }

    
  });
 _controller2.addListener(() {
if (_controller2.position.atEdge ) {
      if (_controller2.position.pixels == 0){
        setState(() {
          _chckSwitch = true;
          _chckSwitch2 = false;
          _controller.animateTo(_controller.position.pixels - 20.0, duration: Duration(milliseconds: 300), curve: Curves.linear);
        });
      }}
 });


}
Future blackshadowup(){
  Future.delayed(const Duration(milliseconds: 50), () {
    setState(() {
      blackshadow = 40.0;
    });
  });
}

Future removeFromWhisList(var wishListState, var loginState, var productList){
  Future.delayed(const Duration(milliseconds: 100), () {
    wishListState.removeFromWishList(loginState.userID, productList[widget.index].id);
  });
}


  double blackshadow = 0;
  bool _chckSwitch = true;
  bool _chckSwitch2 = false;
  bool backbutton = true;
  @override
   Widget build(BuildContext context) {
     blackshadowup();


//provider
    var getProductsState = Provider.of<GetProducts>(context);
    var loginState = Provider.of<LoginState>(context);
    var wishListState = Provider.of<WishListState>(context);
      var productList;
    if(widget.fromWhishList){
      productList = wishListState.wishList;
    }else{
      productList = getProductsState.productList;
    }
    
    


    if(productList.length == 0){
          getProductsState.loadProducts();
    }
    return Scaffold(
      body: Container(
      color: Colors.black,
      child: ListView(
        controller: _controller,
        physics: _chckSwitch2 ? const  NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
        
          Container(
            height: 250,
            color: Colors.black,
              child:Stack(children: <Widget>[
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child:Hero(
                  tag: 'imageHero'+widget.index.toString(),
                  child:Image.network(productList[widget.index].url,fit: BoxFit.cover,),),
                ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: blackshadow,
                        decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                      )
                  ],)
                ),
                

              ],) 
              
              
            
          ),
          
          AnimatedContainer(
            duration: Duration(milliseconds: 600),
            
            curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
                    color: Color(0xFFBE0029),
                    borderRadius: !_chckSwitch? BorderRadius.only( 
                      //delte border
                    ): BorderRadius.only( 
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0),
                    )
                  ),
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[

              Container(
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    //backbutton
                    backbutton?IconButton(icon: Icon(Icons.navigate_before,color: Colors.white,size: 25,),
                    onPressed: (){
                      print("i want back");
                      Navigator.pop(context);

                    },):
                    SizedBox(width: 25,),

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


              Expanded(
                flex: 1,
                child:Container( 
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only( 
                      topLeft: Radius.circular(36.0),
                      topRight: Radius.circular(36.0),
                    )
                  ),
                  
                  child:ListView(
                  controller: _controller2,
                  physics: _chckSwitch ? const  NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(), 
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          
                       Text(productList[widget.index].name,style: TextStyle(
                       fontSize: 40,
                       fontWeight: FontWeight.w600
                       ),),
                       SizedBox(height: 20,),
                       Text(productList[widget.index].description,style: TextStyle(
                         fontSize: 18,
                       ),),
                       SizedBox(height: 20,),
                       Text("prijs: €" +productList[widget.index].prijs.toStringAsFixed(2),
                       style: TextStyle(
                         fontSize: 18,
                       ),),
                       SizedBox(height: 50,),
                       
                      loginState.userID !=null?

                      RaisedButton(
                        child: 
                        
                        wishListState.isInList(productList[widget.index].id)?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          Icon(Icons.delete,color: Colors.white,),
                          Text("verwijderen uit verlanglijst",style: TextStyle(
                          color: Colors.white
                        ),),
                        ],)
                        :
                        Text("toevoegen aan verlanglijst",style: TextStyle(
                          color: Colors.white
                        ),),
                        
                      
                        onPressed: (){
                          if(wishListState.isInList(productList[widget.index].id)){
                            Navigator.pop(context);
                            removeFromWhisList(wishListState,loginState,productList);

                          }else {
                            wishListState.addToWishList(productList[widget.index].id, loginState.userID);
                          }
                        },
                        color: Color(0xFFBE0029),
                      ):
                      Text("login om toe te voegen aan verlanglijst"),
                       SizedBox(height: 150,),
                        
                      ],),
                    )
                    
                  ],
                ),
                
                )
              )
              


            ],),
          )
         



        ],
    )));
  }
}