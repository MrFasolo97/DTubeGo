import 'package:dtube_go/utils/GlobalStorage/globalVariables.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class AdvertisementDesktop extends StatefulWidget {
  AdvertisementDesktop({
    Key? key,
    this.iframe = "<iframe data-aa='2232160' src='https://acceptable.a-ads.com/2232160' style='border:0px; padding:0; width:100%; height:100%; overflow:hidden; background-color: transparent;'></iframe>",
  }) : super(key: key);
  String iframe;
  @override
  _AdvertisementStateDesktop createState() => _AdvertisementStateDesktop();
}

class _AdvertisementStateDesktop extends State<AdvertisementDesktop> {
  late PlatformWebViewController _controller;
  @override
  void initState() {
    WebViewPlatform.instance = WebWebViewPlatform();
    _controller = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )..loadHtmlString(widget.iframe);
  }

  @override
  Widget build(BuildContext context) {
    globals.scrolledPostsBetweenAds = 0;
    return PlatformWebViewWidget(
      PlatformWebViewWidgetCreationParams(controller: _controller),
    ).build(context);
  }
}
