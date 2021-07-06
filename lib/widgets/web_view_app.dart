import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_version.dart';

class WebViewApp extends StatefulWidget {
  final String site;
  final AppVersion version;

  const WebViewApp({
    Key? key,
    required this.site,
    required this.version,
  }) : super(key: key);

  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  NavigationDecision _navigationDelegate(NavigationRequest request) {
    if (!request.isForMainFrame || request.url.startsWith('${widget.site}/')) {
      return NavigationDecision.navigate;
    }

    _launchURL(request.url);
    return NavigationDecision.prevent;
  }

  Future<void> _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: '${widget.site}/',
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: const <JavascriptChannel>{},
          navigationDelegate: _navigationDelegate,
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }
}
