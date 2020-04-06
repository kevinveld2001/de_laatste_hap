import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/getProducts.dart';



class ProductInfo extends StatefulWidget {
   ProductInfo(this.index);
  final int index;
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
          
        });
      }}
 });


}
Future blackshadowup(){
  Future.delayed(const Duration(milliseconds: 200), () {
    setState(() {
      blackshadow = 40.0;
    });
  });
}


  double blackshadow = 0;
  bool _chckSwitch = true;
  bool _chckSwitch2 = false;
  bool backbutton = true;
  @override
   Widget build(BuildContext context) {
     blackshadowup();
    var getProductsState = Provider.of<GetProducts>(context);
    if(getProductsState.productList.length == 0){
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
                  child:Image.network(getProductsState.productList[widget.index].url,fit: BoxFit.cover,),),
                ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      AnimatedContainer(
                        duration: Duration(milliseconds: 600),
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
                          
                       Text(getProductsState.productList[widget.index].name,style: TextStyle(
                       fontSize: 40,
                       fontWeight: FontWeight.w600
                       ),),
                       SizedBox(height: 20,),
                       Text(getProductsState.productList[widget.index].description,style: TextStyle(
                         fontSize: 18,
                       ),),
                       SizedBox(height: 20,),
                       Text("prijs: €" +getProductsState.productList[widget.index].prijs.toStringAsFixed(2),
                       style: TextStyle(
                         fontSize: 18,
                       ),),
                       SizedBox(height: 20,),
                       
                      RaisedButton(
                        child: Text("toevoegen aan verlanglijst"),
                        onPressed: (){},
                      ),
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