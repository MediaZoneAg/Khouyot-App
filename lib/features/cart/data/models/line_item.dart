class LineItems {
  int? productId;
  int? quantity;
  int? variationId;

  LineItems({this.productId, this.quantity, this.variationId});

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    variationId = json['variation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['variation_id'] = this.variationId;
    return data;
  }
}
