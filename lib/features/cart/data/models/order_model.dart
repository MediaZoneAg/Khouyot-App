

import 'package:khouyot/features/cart/data/models/billing_model.dart';
import 'package:khouyot/features/cart/data/models/line_item.dart';
import 'package:khouyot/features/cart/data/models/shipping_lines_model.dart';
import 'package:khouyot/features/cart/data/models/shipping_model.dart';

class OrderModel {
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  Billing? billing;
  Shipping? shipping;
  List<LineItems>? lineItems;
  List<ShippingLines>? shippingLines;

  OrderModel(
      {this.paymentMethod,
      this.paymentMethodTitle,
      this.setPaid,
      this.billing,
      this.shipping,
      this.lineItems,
      this.shippingLines});

  OrderModel.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    setPaid = json['set_paid'];
    billing =
        json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if (json['line_items'] != null) {
      lineItems = <LineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add(new LineItems.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <ShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(new ShippingLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['set_paid'] = this.setPaid;
    if (this.billing != null) {
      data['billing'] = this.billing!.toJson();
    }
    if (this.shipping != null) {
      data['shipping'] = this.shipping!.toJson();
    }
    if (this.lineItems != null) {
      data['line_items'] = this.lineItems!.map((v) => v.toJson()).toList();
    }
    if (this.shippingLines != null) {
      data['shipping_lines'] =
          this.shippingLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}