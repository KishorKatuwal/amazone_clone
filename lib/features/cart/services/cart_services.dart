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

class CartServices{


  void  removeFromCart(
      {
        //build context to display error
        required BuildContext context,
        required Product product,

      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {

      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
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






}