

import 'package:khouyot/core/models/product_model.dart';

import '../../../product_details/data/model/prodec_details_model.dart';

class CartItemModel {
  final Data productModel;
  int quantity;
  int variantId;

  CartItemModel({required this.productModel,this.quantity=1,this.variantId=0});

}
