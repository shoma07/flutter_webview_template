import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(home: WebViewApp()));

class WebViewApp extends StatefulWidget {
  @override
  WebViewAppState createState() => new WebViewAppState();
}

class WebViewAppState extends State<WebViewApp> {
  final String _site = 'https://flutter.dev';

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: SafeArea(child: buildWebView()));

  Widget buildWebView() => WebView(
      initialUrl: _site,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        if (!request.isForMainFrame || request.url.startsWith('$_site/'))
          return NavigationDecision.navigate;

        _launchInBrowser(request.url);
        return NavigationDecision.prevent;
      },
      gestureNavigationEnabled: true);

  Future<void> _launchInBrowser(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
