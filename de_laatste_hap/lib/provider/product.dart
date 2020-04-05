

class Product {

Product(this._name,this._description,this._prijs,this._url,this._id);

final String _name;
final String _url;
final String _description;
final double _prijs;
final String _id;

String get name => _name;
String get url => _url;
String get description => _description;
double get prijs => _prijs;
String get id => _id;

}