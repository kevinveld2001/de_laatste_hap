import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/services.dart';

//profider
import 'provider/getProducts.dart';
import 'provider/login.dart';
import 'provider/verlanglijst.dart';
import 'provider/tafel.dart';
import 'provider/adminCheck.dart';
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
        ChangeNotifierProvider<LoginState>(create: (_) => LoginState()),
        ChangeNotifierProvider<WishListState>(create: (_) => WishListState()),
        ChangeNotifierProvider<TafelState>(create: (_) => TafelState()),
        ChangeNotifierProvider<AdminCheck>(create: (_) =>AdminCheck()),
      ],
      child:MaterialApp(
      title: 'de laatste hap',
      theme: ThemeData(
        fontFamily: "sen",
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
  String _admincheckdoneonUserID;
  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<LoginState>(context);
    var adminCheckState = Provider.of<AdminCheck>(context);


    


    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
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
        elevation: 18,
        
        items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(backgroundColor: primeColor, icon: Icon(Icons.home, color: Colors.black,), activeIcon: Icon(Icons.home, color: Colors.red,), title: Text("start")),
            BubbleBottomBarItem(backgroundColor: primeColor, icon: Icon(Icons.favorite, color: Colors.black,), activeIcon: Icon(Icons.favorite, color: Colors.red,), title: Text("verlanglijst")),
            BubbleBottomBarItem(backgroundColor: primeColor, icon: Icon(Icons.edit, color: Colors.black,), activeIcon: Icon(Icons.edit, color: Colors.red,), title: Text("reserveren")),
            if(adminCheckState.isAdmin)
            BubbleBottomBarItem(backgroundColor: primeColor, icon: Icon(Icons.dashboard, color: Colors.black,), activeIcon: Icon(Icons.dashboard, color: Colors.red,), title: Text("admin page"))
            
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
    var loginState = Provider.of<LoginState>(context);
    var adminCheckState = Provider.of<AdminCheck>(context);


    if(loginState.userID != null){
      if(loginState.userID != adminCheckState.checkedID){
        adminCheckState.checkIfIamAdmin(loginState.userID);
      }
    }
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
      case 3:
        return Text("you are a admin");
      break;
    }
    return Text("error");
  }
}


