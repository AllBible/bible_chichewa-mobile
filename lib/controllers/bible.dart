import 'package:bible_chichewa/bible_chichewa.dart';
import 'package:get/get.dart';

class BibleController extends GetxController {
  final bible = Bible().obs;
  Future load() async => await bible.value.init();
}
