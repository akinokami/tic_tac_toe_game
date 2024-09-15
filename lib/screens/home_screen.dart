import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/constants/font_style_const.dart';
import 'package:tic_tac_toe/constants/img_const.dart';
import 'package:tic_tac_toe/constants/string_const.dart';
import 'package:tic_tac_toe/screens/score_screen.dart';
import 'package:tic_tac_toe/screens/tic_tac_toe_screen.dart';
import 'package:tic_tac_toe/utils/global.dart';
import 'package:tic_tac_toe/widgets/cus_outline_gradient_rect_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../languages/enum.dart';
import '../widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAccepted = false;
  bool isChecked = false;
  int firstTime = 0;
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        firstTime = prefs.getInt('firstTime') ?? 0;

        print("First Time: $firstTime");
        if (firstTime == 0) {
          if (context.mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Builder(builder: (context) {
                return StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return AlertDialog(
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              child: SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.65,
                                  width: double.infinity,
                                  //width: MediaQuery.of(context).size.width * 0.90,
                                  child: WebViewWidget(
                                      controller: WebViewController()
                                        ..loadHtmlString( Global.language == Language.zh.name
                                            ? Global.policyZh:Global.policyEn))
                              ),
                            ),
                            // Text(Global.policy, style: TextStyle(fontSize: 12)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  activeColor: Colors.green,
                                  side: BorderSide(
                                    width: 1.5,
                                    color:
                                    isChecked ? Colors.green : Colors.black,
                                  ),
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                      if (isChecked) {
                                        isAccepted = true;
                                      } else {
                                        isAccepted = false;
                                      }
                                    });
                                  },
                                ),
                                CustomText(text:"agree".tr,
                                  fontSize: 11.sp,)
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateColor.resolveWith((states) =>
                                  isAccepted
                                      ? Colors.green
                                      : Colors.grey)),
                              onPressed: isAccepted
                                  ? () async {
                                SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                                prefs.setInt('firstTime', 1);
                                if(context.mounted) Navigator.pop(context);
                              }
                                  : null,
                              child: Text(
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                                "accept".tr,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            );
          }
        }
      } catch (e) {
        print("Error fetching SharedPreferences: $e");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(modeImgPath),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              Image.asset(
                homeGifImgPath,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * .6,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOutlineGradientButton(
                      padding: 80,
                      horizon: 24,
                      vertical: 12,
                      data: Text('single_player'.tr, style: homeButtonStyle),
                      onPressed: () {
                        // Future.delayed(const Duration(milliseconds: 800), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TicTacToeHomePage(singlePlayer: true)),
                        );
                        //});
                      },
                      buttonStyle: homeButtonStyle),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  CustomOutlineGradientButton(
                      padding: 80,
                      horizon: 24,
                      vertical: 12,
                      data: Text('multi_player'.tr, style: homeButtonStyle),
                      onPressed: () {
                        // Future.delayed(const Duration(milliseconds: 800), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const TicTacToeHomePage(singlePlayer: false)),
                        );
                        //});
                      },
                      buttonStyle: homeButtonStyle),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  CustomOutlineGradientButton(
                      padding: 80,
                      horizon: 24,
                      vertical: 12,
                      data: Text('settings'.tr, style: homeButtonStyle),
                      onPressed: () {
                        // Future.delayed(const Duration(milliseconds: 800), () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScoreScreen()),
                        );
                        //});
                      },
                      buttonStyle: homeButtonStyle),
                  const SizedBox(height: 20),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text(
                    "exit".tr,
                    style: GoogleFonts.gamjaFlower(
                        color: Colors.white, fontSize: 30),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
