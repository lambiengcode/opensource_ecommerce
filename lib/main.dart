import 'package:delivery_hub/src/app.dart';
import 'package:delivery_hub/src/lang/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Whoru',
    //showPerformanceOverlay: true,
    debugShowCheckedModeBanner: false,
    initialRoute: '/root',
    defaultTransition: Transition.native,
    locale: TranslationService.locale,
    fallbackLocale: TranslationService.fallbackLocale,
    translations: TranslationService(),
    getPages: [
      GetPage(
        name: '/root',
        page: () => App(),
      ),
    ],
  ));
}
