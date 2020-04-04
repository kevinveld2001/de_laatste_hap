import 'package:flutter/material.dart';







class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();

}

class _StartState extends State<Start> {
  
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


  bool _chckSwitch = true;
  bool _chckSwitch2 = false;
  @override
   Widget build(BuildContext context) {
     
    return Container(
      color: Colors.black,
      child: ListView(
        controller: _controller,
        physics: _chckSwitch2 ? const  NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          
          Container(
            height: 250,
            color: Colors.black,

            child: Image.asset("packages/de_laatste_hap/assets/header.jpg",fit: BoxFit.cover,),
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
            height: MediaQuery.of(context).size.height - 60,
            child: Column(children: <Widget>[

              Container(
                height: 90,
                
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
                        for(int i =0 ; i<100; i++)
                          Text("dit is tekt $i")
                        
                      ],),
                    )
                    
                  ],
                ),
                
                )
              )
              


            ],),
          )
         



        ],
    ));
  }
}