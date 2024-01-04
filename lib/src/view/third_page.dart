import 'package:flutter/material.dart';
import 'package:flutter_getx/src/common/pages.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controller/counter.dart';

class GetThirdPage extends StatelessWidget {
  const GetThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterController c = Get.find();

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Get Third Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Total counter :'),
            Text(
              c.count.toString(),
              style: Theme.of(context).textTheme.headlineMedium,  
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: Get.back, 
              child: const Text('Go back')
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('dslkf;sldf'), 
              child: const Text('Go to unknown')
            ),
          ],
        ),
      ),
    );
  }
}