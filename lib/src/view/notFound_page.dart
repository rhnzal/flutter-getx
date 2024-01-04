import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controller/counter.dart';

class GetNotFoundPage extends StatelessWidget {
  const GetNotFoundPage({super.key});

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
            Text('Total counter :'),
            Text(
              c.count.toString(),
              style: Theme.of(context).textTheme.headlineMedium,  
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: Get.back, 
              child: Text('Go back')
            ),
          ],
        ),
      ),
    );
  }
}