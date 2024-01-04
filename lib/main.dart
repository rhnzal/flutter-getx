import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx/src/common/pages.dart';
import 'package:flutter_getx/src/view/notFound_page.dart';
import 'package:flutter_getx/src/view/second_page.dart';
import 'package:flutter_getx/src/view/third_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uni_links/uni_links.dart';

import 'src/view/home_page.dart';

bool _initialURILinkHandled = false;
Uri? _initialURI;
Uri? _currentURI;
Object? _err;

StreamSubscription? _streamSubscription;

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _initURIHandler();
    _incomingLinkHandler();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initURIHandler() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;

      log('init terinjak');

      try {
        final initialURI = await getInitialUri();

        if (initialURI != null) {
          log('Initial URI received $initialURI');
          if (!mounted) {
            return;
          }
          setState(() {
            _initialURI = initialURI;
          });
          Get.toNamed(_initialURI?.path ?? AppPage.notFoundPage);
        } else {
          log('Initial URI is NULL');
        }
      } on PlatformException {
        log('Failed to receive initial URI');
      } on FormatException catch (err) {
        if (!mounted) {
          return;
        }
        log('Malformed Initial URI received');
        setState(() {
          _err = err;
        });
      }
    }
  }

  void _incomingLinkHandler() {
    if (!kIsWeb) {
      _streamSubscription = uriLinkStream.listen(
        (Uri? uri) {
          if (!mounted) {
            return;
          }
          log('Received URI: $uri');
          setState(() {
            _currentURI = uri;
            _err = null;
          });
          log(_currentURI?.path ?? '');
          Get.toNamed(_currentURI?.path ?? AppPage.notFoundPage);
        }, onError: (Object err) {
          if (!mounted) {
            return;
          }
          log('Error occured: $err');
          setState(() {
            _currentURI = null;
            if (err is FormatException) {
              _err = err;
            } else {
              _err = null;
            }
          });
        }
      );
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeData theme = GetStorage().read('theme') == 'dark' ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      unknownRoute: GetPage(name: AppPage.notFoundPage, page: () => const GetNotFoundPage()),
      initialRoute: AppPage.homePage,
      defaultTransition: Transition.cupertino,
      getPages: [
        GetPage(name: AppPage.homePage, page: () => const GetHomePage(), transition: Transition.cupertino),
        GetPage(name: AppPage.secondPage, page: () => const GetSecondPage(), transition: Transition.cupertino),
        GetPage(name: AppPage.thirdPage, page: () => const GetThirdPage(), transition: Transition.cupertino),
      ],
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const GetHomePage(),
    );
  }
}