import 'package:flutter/foundation.dart';
import 'product.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class WishListState with ChangeNotifier{

List<Product> _wishList = [];

List<Product> get wishList => _wishList;


///
///load your wishlist form firebase using your [userID]
///it will get document ids from the items the user saved
///[productList] will be sorted by the docID's it got from the wish list
///
void loadWishList(String userID,List<Product> productList) async{
  Firestore.instance
    .collection('wishList/$userID/List')
    .snapshots()
    .listen((data) {
      _wishList=  [];
      data.documents.forEach((ds){
        print(ds.data["id"].toString());

        for(int i=0;i<productList.length;i++){
          if(productList[i].id == ds.data["id"].toString()){
            _wishList.add(productList[i]);
          }
        }
      });
      notifyListeners();
    });
       
}

///will add a product to wish list from the user
///needs [userID] to find right user
///and needs [docID] to save
void addToWishList(String docID, String userID){
  Firestore.instance
    .collection('wishList/$userID/List')
    .document()
    .setData({
      'id': docID
    });
    _wishList = [];
    notifyListeners();

}
///checks if doc is in wish list already
///it needs [docID] and gives true or false
bool isInList(String docID){
  for(int i=0;i<_wishList.length;i++){
    if(_wishList[i].id == docID){ 
      return true;
    }
  }
  return false;
}


///removes all doc with the [docid] form 
///list from the uiser by [userID]
void removeFromWishList(String userID, String docID){
Firestore.instance
    .collection("wishList/$userID/List")
    .where("id", isEqualTo: docID)
    .getDocuments().then((snapshot){
      for(DocumentSnapshot doc in snapshot.documents){
        doc.reference.delete();
      }
    });
_wishList = [];
notifyListeners();
    

}

void clearList(){
  _wishList=  [];
  notifyListeners();
}


  
}