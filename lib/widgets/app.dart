import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../utils/app_version.dart';
import './web_view_app.dart';

class App extends StatelessWidget {
  final bool disableDebugBanner;
  final String title;
  final String site;
  final AppVersion version;

  const App({
    Key? key,
    required this.disableDebugBanner,
    required this.title,
    required this.site,
    required this.version,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: !disableDebugBanner,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja')],
      home: WebViewApp(
        site: site,
        version: version,
      ),
    );
  }
}
