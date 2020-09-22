// Project imports:
import 'package:rshb_test/models/category.dart';

const productJsonExample = {
  "id": 1,
  "categoryId": 3,
  "farmer": "Молочный рай",
  "title": "Молоко 5%",
  "unit": "1л",
  "totalRating": 4.9,
  "ratingCount": 1,
  "image": "images/cheese.jpeg",
  "shortDescription":
      "Наше молоко и сливки поступают на завод в тот же день, когда доят коров.",
  "description":
      "Наше молоко и сливки поступают на завод в тот же день, когда доят коров, и это свежее пастеризованное для обеспечения качества при сохранении его свежего фермерского вкуса и питательной ценности. Мы делаем это, чтобы ваша семья могла наслаждаться клеверным молоком и сливками с чистой совестью и хорошим здоровьем! Без гармона роста (rBST) \nи без антибиотиков — свежего пастеризованного для обеспечения качества — без глютена — \nс низким содержанием натрия.",
  "price": 100.0,
  "favorite": false,
  "characteristics": [
    {"title": "Вес продукта", "value": "1,680 кг"},
    {"title": "Вес продукта с упаковкой", "value": "1,700 кг"},
    {"title": "Категория", "value": "Сырный продукт"},
    {"title": "Тип маркировки", "value": "Столовое"},
    {"title": "Срок годности", "value": "7 суток"},
    {"title": "Вес продукта", "value": "1,680 кг"},
    {"title": "Вес продукта с упаковкой", "value": "1,700 кг"},
    {"title": "Категория", "value": "Сырный продукт"},
    {"title": "Тип маркировки", "value": "Столовое"},
    {"title": "Срок годности", "value": "7 суток"},
    {"title": "Вес продукта", "value": "1,680 кг"}
  ]
};

class Product {
  int id;
  Category category;
  String farmer;
  String title;
  String unit;
  num rating;
  int ratingCount;
  String shortDescription;
  String description;
  String image;
  num price;
  bool favorite;
  List<Characteristic> characteristics;

  Product(
      {this.id,
      this.category,
      this.farmer,
      this.title,
      this.unit,
      this.rating,
      this.ratingCount,
      this.shortDescription,
      this.image,
      this.description,
      this.price,
      this.favorite,
      this.characteristics});
  factory Product.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    var _characteristics = <Characteristic>[];
    if (json['characteristics'] is List) {
      _characteristics = List<Characteristic>.from(
          (json['characteristics'] as List)
                  ?.map((c) => Characteristic.fromJson(c))
                  ?.toList() ??
              []);
    }
    return Product(
      id: json['id'],
      category: Category(json['categoryId']),
      farmer: json['farmer'],
      title: json['title'],
      unit: json['unit'],
      rating: json['totalRating'],
      ratingCount: json['ratingCount'],
      shortDescription: json['shortDescription'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      favorite: json['favorite'],
      characteristics: _characteristics,
    );
  }
}

class Characteristic {
  String title;
  String value;
  Characteristic({this.title, this.value});

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return Characteristic(
      title: json['title'],
      value: json['value'],
    );
  }
}
