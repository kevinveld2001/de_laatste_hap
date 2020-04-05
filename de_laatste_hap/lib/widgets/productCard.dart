import 'package:flutter/material.dart';


class ProductCard extends StatelessWidget {
  ProductCard(this.url,this.title,this.prijs);
  final String url;
  final String title;
  final double prijs;
  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 3,
      child: Container(
        width: 280,
        height: 115,
        child: Row(
          children: <Widget>[
          
             Stack(
              children: <Widget>[
                Container(
                  height: 115,
                  width: 115,
                  color:Colors.black,
                  child:Image.network(url,fit: BoxFit.cover,)
                ),
                
                Container(
                  height: 115,
                  width: 115,
                  alignment: Alignment.centerRight,
                  child:Container(
                    height: 115,
                    child: Image.asset("packages/de_laatste_hap/assets/card.png",fit: BoxFit.fitHeight,),
                  )
                  
                ),
                

              ],
            ),
          
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child:Padding( 
                padding: EdgeInsets.all(10),
                child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(title,style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),),
                  Text("€"+prijs.toStringAsFixed(2),style: TextStyle(
                    
                    fontSize: 15
                  ),)
                ],
              ),
            ),),
          )

        ],),
      ),
    );
  }
}