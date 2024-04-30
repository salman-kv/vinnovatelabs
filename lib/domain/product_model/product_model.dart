// custome product model for specific data about the product
class ProductModel {
  final int id;
  final String title;
  final num price;
  final String image;
  final String category;
  final Map<String, num> rating;

  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.category,
      required this.image,
      required this.rating});

  static ProductModel fromMap(Map<dynamic, dynamic> map) {
    return ProductModel(
        category: map['category'],
        id: map['id'],
        title: map['title'],
        price: map['price'],
        image: map['image'],
        rating: {
          'rate': map['rating']['rate'],
          'count': map['rating']['count'],
        });
  }
}
