import 'package:dtube_go/utils/GlobalStorage/globalVariables.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'package:flutter/material.dart';

class Advertisement extends StatefulWidget {
  Advertisement({
    Key? key,
    this.iframe = "<iframe data-aa='2232160' src='https://acceptable.a-ads.com/2232160' style='border:0px; padding:0; width:100%; height:100%; overflow:hidden; background-color: transparent;'></iframe>",
  }) : super(key: key);
  String iframe;
  @override
  _AdvertisementState createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  late PlatformWebViewController _controller;
  @override
  void initState() {
    WebViewPlatform.instance = WebWebViewPlatform();
    _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadHtmlString(widget.iframe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    globals.scrolledPostsBetweenAds = 0;
    return Padding(padding: EdgeInsets.only(top: 16), child:
    PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: _controller),
    ).build(context));
  }
}
