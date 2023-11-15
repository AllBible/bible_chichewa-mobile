import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BibleController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final bible = Bible().obs;
  var fontSize = 18.0.obs;
  var lightMode = true.obs;
  var comments = [].obs;
  var highlights = [].obs;

  Future load() async => await bible.value.init();

  void toggleLightMode() async {
    lightMode.value = !lightMode.value;
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('light', lightMode.value);
  }

  void updateFontSize(double font) async {
    fontSize.value = font;
    final SharedPreferences prefs = await _prefs;
    await prefs.setDouble('font', font);
  }

  void loadSettings() async {
    final SharedPreferences prefs = await _prefs;
    var light = prefs.getBool('light');
    var font = prefs.getDouble('font');
    light ??= true;
    font ??= 18.0;
    lightMode.value = light;
    fontSize.value = font;
  }
}
