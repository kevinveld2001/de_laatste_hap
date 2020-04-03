import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
//profider
import 'provider/getProducts.dart';

//screens
import 'screens/reserveren.dart';
import 'screens/start.dart';
import 'screens/verlanglijst.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GetProducts>(create: (_) => GetProducts()),
      ],
      child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: primeColor,
      ),
      home: Screenbuilder(),
    ) ,
    );
    
    
  }
}





Map<int, Color> color =
{
50:Color.fromRGBO(136,14,79, .1),
100:Color.fromRGBO(136,14,79, .2),
200:Color.fromRGBO(136,14,79, .3),
300:Color.fromRGBO(136,14,79, .4),
400:Color.fromRGBO(136,14,79, .5),
500:Color.fromRGBO(136,14,79, .6),
600:Color.fromRGBO(136,14,79, .7),
700:Color.fromRGBO(136,14,79, .8),
800:Color.fromRGBO(136,14,79, .9),
900:Color.fromRGBO(136,14,79, 1),
};

MaterialColor primeColor = MaterialColor(0xFFBE0029, color);







class Screenbuilder extends StatefulWidget {
  @override
  _ScreenbuilderState createState() => _ScreenbuilderState();
}

class _ScreenbuilderState extends State<Screenbuilder> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ScreenSelect(_currentIndex),


        
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: _currentIndex,
        onTap: (page){
          setState(() {
            _currentIndex = page;
          });

        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        hasInk: true, //new, gives a cute ink effect
        inkColor: Colors.black12, //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(backgroundColor: primeColor, icon: Icon(Icons.home, color: Colors.black,), activeIcon: Icon(Icons.home, color: Colors.red,), title: Text("start")),
            BubbleBottomBarItem(backgroundColor: primeColor, icon: Icon(Icons.favorite, color: Colors.black,), activeIcon: Icon(Icons.favorite, color: Colors.red,), title: Text("verlanglijst")),
            BubbleBottomBarItem(backgroundColor: primeColor, icon: Icon(Icons.edit, color: Colors.black,), activeIcon: Icon(Icons.edit, color: Colors.red,), title: Text("reserveren")),
            
        ],
      ),

    );
  }
}



class ScreenSelect extends StatelessWidget {
  ScreenSelect(this.page);
  final int page;
  @override
  Widget build(BuildContext context) {
    switch(page){
      case 0:
        return Start();
      break;
      case 1:
        return Verlanglijst();
      break;
      case 2:
        return Reserveren();
      break;
    }
    return Text("error");
  }
}


