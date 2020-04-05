import 'package:flutter/foundation.dart';
import 'product.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class GetProducts with ChangeNotifier{

List<Product> _productList = [];

List<Product> get productList => _productList;


void loadProducts() async{
  Firestore.instance
    .collection('products')
    .snapshots()
    .listen((data) {
      _productList=  [];
      data.documents.forEach((ds){
        print("id: "+ds.documentID);
        print("name: "+ds.data["name"]);
        print("description: "+ds.data["description"]);
        print("prijs: "+ds.data["prijs"].toString());
        print("url: "+ds.data["url"]);
        print("-----------------");
        _productList.add(new Product(
          ds.data["name"],
          ds.data["description"],
          ds.data["prijs"],
          ds.data["url"],
          ds.documentID));
      });
      notifyListeners();
    });
       
}



  
}