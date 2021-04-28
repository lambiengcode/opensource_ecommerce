import 'package:van_transport/src/lang/translation_service.dart';
import 'package:van_transport/src/routes/app_pages.dart';
import 'package:van_transport/src/shared/logger_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Delivery Hub',
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
