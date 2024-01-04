import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_getx/src/controller/counter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// Flutter biasa
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    log(_counter.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// Getx
class GetHomePage extends StatelessWidget {
  const GetHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterController counterController = Get.put(CounterController());
    GetStorage box = GetStorage();

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Test GetX'),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(Get.isDarkMode ? ThemeData.light(useMaterial3: true) : ThemeData.dark(useMaterial3: true));
              box.write('theme', Get.isDarkMode ? 'light' : 'dark');
            },
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Change Theme',
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() => Text(
                counterController.count.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: counterController.goToSecondPage, 
              child: const Text('Go to Second Page')
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}