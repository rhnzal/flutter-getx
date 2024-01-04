import 'package:flutter_getx/src/common/pages.dart';
import 'package:flutter_getx/src/view/second_page.dart';
import 'package:get/get.dart';

class CounterController extends GetxController{
  var count = 0.obs;

  void increment() {
    count++;
  }

  void goToSecondPage() => Get.toNamed(AppPage.secondPage);
}