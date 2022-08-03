import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/Provider.dart';
import 'package:http/http.dart' as http;
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';

class ProductDetailsServices{


  void  addToCart(
      {
        //build context to display error
        required BuildContext context,
        required Product product,

      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
              User user = userProvider.user.copyWith(
                cart: jsonDecode(res.body)['cart']
              );
              userProvider.setUserFromModel(user);
          });
    } catch (e) {
      print("Failed on add producrt to cart");
      showSnackBar(context, e.toString());
    }
  }




  void rateProduct(
      {
        //build context to display error
        required BuildContext context,
        required Product product,
        required double rating,
     }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
          });
    } catch (e) {
      print("Failed on admin service catch");
      showSnackBar(context, e.toString());
    }
  }

  //getting all the product from the database
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
      await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print("I am here");
    }
    return productList;
  }

  void deleteProduct(
      {required BuildContext context,
        required Product product,
        required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      print("Failed on admin service catch");
      showSnackBar(context, e.toString());
    }
  }
}