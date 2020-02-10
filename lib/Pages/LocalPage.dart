import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_app/Sidebar.dart';

class LocalPage extends StatefulWidget {
  @override
  _LocalPageState createState() => _LocalPageState();
}

class _LocalPageState extends State<LocalPage> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('本地疫情', textAlign: TextAlign.center,),
        centerTitle: true,
        actions: <Widget>[ //导航后面的图标
          IconButton(icon: Icon(Icons.refresh,),
              onPressed: () {
                webView.reload();
              }
          ),
        ],
      ),
      body: Container(
          child: Column(children: <Widget>[
            Container(
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: Container(
                child: InAppWebView(
                  initialUrl: "http://m.wh.bendibao.com/news/xinxingfeiyan/",
                  initialHeaders: {},
                  initialOptions: InAppWebViewWidgetOptions(
                      inAppWebViewOptions: InAppWebViewOptions(
                        debuggingEnabled: true,
                      )),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart: (InAppWebViewController controller,
                      String url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onLoadStop:
                      (InAppWebViewController controller, String url) async {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ),
          ])),
      drawer: Builder(
        builder: (context) =>
            Drawer(
              child: Sidebar(),
            ),

      ),
    );
  }
}
