
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:tic_tac_toe/languages/zh_language.dart';
import 'en_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN': ZhLanguage().zhLanguage,
    'en_US': EnLanguage().enLanguage,
  };
}
