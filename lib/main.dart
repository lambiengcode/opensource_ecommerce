import 'package:ecommerce_ec/src/lang/translation_service.dart';
import 'package:ecommerce_ec/src/routes/app_pages.dart';
import 'package:ecommerce_ec/src/shared/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Delivery Hub',
    // showPerformanceOverlay: true,
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.native,
    locale: TranslationService.locale,
    fallbackLocale: TranslationService.fallbackLocale,
    translations: TranslationService(),
    enableLog: true,
    logWriterCallback: Logger.write,
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  ));
}
