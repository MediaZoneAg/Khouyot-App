import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/networking/api_constants.dart';
import 'package:khouyot/features/cart/data/models/billing_model.dart';
import 'package:khouyot/features/cart/data/models/order_model.dart';



class CartRepo {
  final Dio dio;
  const CartRepo(this.dio);
  Future<Either<ApiErrorModel, String>> placeOrder(OrderModel orderModel)  async {
    try {
      Response response = await dio.post(
          ApiConstants.addToCart, data: orderModel.toJson(),
      options: Options(headers: {  "authorization":  'Basic ${base64Encode(utf8.encode('${ApiConstants.secretKey}:${ApiConstants.consumerKey}'))}'
      }),
      );
      return right(response.toString());
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<String, String>> payWithPayMob(double amount,Billing billing) async {
    try {
      String token = await getToken();
      int orderId = await getOrderId(amount: (amount*100).toString(), token: token);
      String paymentKey = await getPaymentKey(
        billing: billing,
          orderId: orderId.toString(), token: token, amount: (amount*100).toString());
      return right(paymentKey);
    } catch (e) {
      print(e.toString());
      return left(e.toString());
    }
  }

  Future<String> getToken() async {
    try {
      Response response =
          await Dio().post('https://accept.paymob.com/api/auth/tokens', data: {
        "api_key":
            "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBeU5qYzVPU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS42RTZobTFzYnJMQW5tVHZWOEU1MW11UU5tNjZuQjBCcmdacl9CU3ByMFJRN3VyYXpLYWlIdHFXYngwZVlYRFhSajRWWlR5bEIzNG1XN2N1X2lXNHJ4dw=="
      });
      print('auth token${response.data['token']}');
      return response.data['token'];
    } catch (e) {
      print(e.toString());

      rethrow;
    }
  }

  Future<int> getOrderId(
      {required String amount, required String token}) async {
    try {
      Response response = await Dio().post(
          'https://accept.paymob.com/api/ecommerce/orders',
          data: {"auth_token": token, "amount_cents": amount});
      print('auth token${response.data['id']}');
      return response.data['id'];
    } catch (e) {
      print(' errror order${e.toString()}');

      rethrow; 
    }
  }

  Future<String> getPaymentKey(
      {required String orderId,
      required String token,
      required String amount,required Billing billing}) async {
    try {
      print('billing${billing.firstName}');
      print('billing${billing.lastName}');
      print('billing${billing.phone}');
      print('billing${billing.email}');
      print('billing${billing.city}');
      print('order id${orderId}');
      print('token${token}');
      
      Response response = await Dio()
          .post('https://accept.paymob.com/api/acceptance/payment_keys', data: {
        "auth_token": token,
        "order_id": orderId,
        "amount_cents": double.parse(amount),
        "currency": "EGP",
        "integration_id": 4997843,
        "billing_data": {
          "apartment": "dumy",
          "first_name": billing.firstName,
          "last_name": billing.lastName,
          "street": "dumy",
          "building": "dumy",
          "phone_number": billing.phone,
          "city": billing.city,
          "country": "dumy",
          "email": "billing.email",
          "floor": "dumy",
          "state": "dumy"
        }
      });
      print('payment key${response.data['token']}');
      return response.data['token'];
    } catch (e) {
      
      print(e.hashCode.toString());

      rethrow;
    }
  }
}

//   Future<Either<ApiErrorModel,List<OrdersHistoryModel>>> getOrder()  async {
//     List<OrdersHistoryModel> orders=[];
//     try{
//       int userId= int.parse(await CashHelper.getStringSecured(key: Keys.userId));
//       Response response = await dio.get('wc/v3/orders?customer=$userId', options: Options(headers: {  "authorization":  'Basic ${base64Encode(utf8.encode('${ApiConstants.secretKey}:${ApiConstants.consumerKey}'))}'}),);
//       for (var order in response.data) {
//         orders.add(OrdersHistoryModel.fromJson(order));
//       }
//         }catch (e) {
//       return left(ApiErrorHandler.handle(e));
//     }
//   }
// }