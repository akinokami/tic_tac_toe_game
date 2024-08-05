import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/policy.dart';

class HomeScreenProvider extends ChangeNotifier{
  bool isAccepted = false;
  bool isChecked = false;
  int firstTime = 0;
  HomeScreenProvider(){

  }

}