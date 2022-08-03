// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'dart:convert';
import 'package:amazone_clone/common/widgets/bottom_bar.dart';
import 'package:amazone_clone/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazone_clone/constants/error_handling.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/models/user.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../admin/screens/admin_screen.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
        cart: []
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      print("Program failed on catch");
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName,
            (route) => false,);

        //   Navigator.pushNamedAndRemoveUntil(
        //       context,
        //       Provider.of<UserProvider>(context, listen: false).user.type ==
        //           'user'
        //           ? BottomBar.routeName
        //           : AdminScreen.routeName,
        //           (route) => false);
        // });


        },
      );
    } catch (e) {
      print("Program failed on catch");
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(Uri.parse('$uri/tokenIsValid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        //get the user data
        http.Response userRes = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }

      // http.Response res = await http.post(
      //   Uri.parse('$uri/api/signin'),
      //   body: jsonEncode({'email': email, 'password': password}),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
      // print(res.body);
    } catch (e) {
      print("Program failed on catch");
      showSnackBar(context, e.toString());
    }
  }
}
