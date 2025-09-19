// ignore_for_file: unused_field, await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.url, required this.title});

  final String title;
  final String url;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  InAppWebViewController? _webViewController;

  @override
  void dispose() {
    _webViewController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          onLoadStop: (controller, url) {
            // JavaScript 인터페이스 추가
            controller.addJavaScriptHandler(
              handlerName: 'phoneCall',
              callback: (args) async {
                if (args.isNotEmpty) {
                  final phoneNumber = args[0].toString();
                  final Uri uri = Uri.parse('tel:$phoneNumber');
                  await launchUrl(uri);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
