import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PnpWidget extends StatefulWidget {
  @override
  _PnpWidgetState createState() => _PnpWidgetState();
}

class _PnpWidgetState extends State<PnpWidget> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  Future<String> get _url async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    return 'https://desawisata.kemendesa.go.id:8443/privacy';
  }

  void _startLoad(String value) {
    CircularProgressIndicator();
  }

  void _handleLoad(String value) {
    // setState(() {
    //   _stackToView = 0;
    // });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0, right: 24.0),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: FutureBuilder<String>(
              future: _url,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  snapshot.hasData
                      ? webViewWidget(snapshot.data)
                      : Container()),
        ));
  }

  Widget webViewWidget(url) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      onPageFinished: _handleLoad,
      onPageStarted: _startLoad,
    );
  }
}
