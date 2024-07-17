import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/policy.dart';

class HomeScreenProvider extends ChangeNotifier{
  bool isAccepted = false;
  bool isChecked = false;
  int firstTime = 0;
  HomeScreenProvider(BuildContext context){



  }
}