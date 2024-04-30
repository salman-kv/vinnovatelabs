import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vinnovatelabzsalmankv/domain/product_model/product_model.dart';

class FakeStoreAPI {
  // api base url
  final String baseUri = 'https://fakestoreapi.com/products';
  // get all product from fakestore api
  getProductDeatails() async {
    http.Response result = await http.get(Uri.parse(baseUri));
    if (result.statusCode == 200) {
      List<dynamic> val = await jsonDecode(result.body);
      List<ProductModel> productList = [];
      for (var i in val) {
        productList.add(ProductModel.fromMap(i));
      }
      return productList;
    } else {
      return null;
    }
  }
}
