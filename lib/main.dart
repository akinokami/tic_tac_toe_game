import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tic_tac_toe/screens/splash_screen.dart';
import 'package:tic_tac_toe/utils/global.dart';
import 'package:tic_tac_toe/utils/local_storage.dart';

import 'languages/enum.dart';
import 'languages/language.dart';


void main() async{
  await LocalStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TicTacToeGame());
}

class TicTacToeGame extends StatelessWidget {
  const TicTacToeGame({super.key});

  @override
  Widget build(BuildContext context) {
    Global.language = LocalStorage.instance.read(StorageKey.language.name) ??
        Language.zh.name;
    return ScreenUtilInit(
        designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) {
    return  GetMaterialApp(
      translations: Languages(),
      locale: Global.language == Language.zh.name
          ? const Locale('zh', 'CN')
          : const Locale('en', 'US'),
      fallbackLocale: const Locale('zh', 'CN'),
    debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
    );},
    );
  }
}







