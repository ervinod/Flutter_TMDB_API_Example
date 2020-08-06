

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper{

  //function to show toast message on screen
  static void showShortToast(BuildContext context, String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT);
  }

  //function to show long time toast message on screen
  static void showLongToast(BuildContext context, String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG);
  }

  //function to check network connectivity
  static Future<bool> isNetworAvailable() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //  debugPrint('connected');
        return true;
      }
    } on SocketException catch (_) {
      //debugPrint('not connected');
      return false;
    }
  }
}