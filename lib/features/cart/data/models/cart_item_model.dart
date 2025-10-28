

import 'package:khouyot/core/models/product_model.dart';

class CartItemModel {
  final ProductModel productModel;
  int quantity;
  int variantId;

  CartItemModel({required this.productModel,this.quantity=1,this.variantId=0});

}
