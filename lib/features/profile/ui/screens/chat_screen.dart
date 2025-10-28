import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewChat extends StatefulWidget {
  @override
  _WebViewChatState createState() => _WebViewChatState();
}

class _WebViewChatState extends State<WebViewChat> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(
                "https://widget.chatway.app/?userId=CkHlCKlUAnti&widgetId=ylenlvog5s3aangyf0kd&bg-color=linear-gradient(100.96deg,%20#E96443%200"), 
          ),
          initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(
              useHybridComposition: true,
            ),
            ios: IOSInAppWebViewOptions(
              allowsInlineMediaPlayback: true,
            ),
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        ),
      ),
    );
  }
}
