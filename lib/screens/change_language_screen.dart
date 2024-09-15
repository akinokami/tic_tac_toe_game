import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/language_controller.dart';
import '../../languages/enum.dart';
import '../../widgets/custom_text.dart';
import '../constants/color_const.dart';
import '../constants/dimen_const.dart';
import '../widgets/cus_outline_gradient_circle_button.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(

        elevation: 0,
        centerTitle: true,  leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomOutlineGradientCircleButton(
          iconData: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        title: CustomText(
          color: Colors.white,
          text: 'change_language'.tr,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/game_bg.webp"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left:10.w,right: 10.w,top:kToolbarHeight+ 50.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                        () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("en", "US");
                      },
                      child:  Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/usa.webp",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: "English",
                                  color: secondaryColor,
                                )
                              ],
                            ),
                            Icon(
                              languageController.language.value ==
                                  Language.en.name
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color: languageController.language.value ==
                                  Language.en.name
                                  ? Colors.green
                                  : greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),
                  kSizedBoxH20,
                  Obx(
                        () => GestureDetector(
                      onTap: () {
                        languageController.changeLanguage("zh", "CN");
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/china.webp",
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: "chinese".tr,
                                  color: secondaryColor,
                                )
                              ],
                            ),
                            Icon(
                              languageController.language.value ==
                                  Language.zh.name
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color: languageController.language.value ==
                                  Language.zh.name
                                  ? Colors.green
                                  : greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
