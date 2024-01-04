import 'package:flutter/material.dart';
import 'package:flutter_getx/src/common/pages.dart';
import 'package:flutter_getx/src/controller/counter.dart';
import 'package:flutter_getx/src/view/third_page.dart';
import 'package:get/get.dart';

class GetSecondPage extends StatelessWidget {
  const GetSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Get Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppPage.thirdPage);
              }, 
              child: const Text('Go to Third Page')
            ),
            ElevatedButton(
              onPressed: Get.back, 
              child: const Text('Go back')
            ),
          ],
        ),
      ),
    );
  }
}