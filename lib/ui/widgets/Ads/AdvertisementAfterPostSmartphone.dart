import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class Advertisement extends StatefulWidget {
  Advertisement({
    Key? key,
    required this.post,
    this.iframe = "<iframe data-aa='2232160' src='https://acceptable.a-ads.com/2232160' style='border:0px; padding:0; width:100%; height:100%; overflow:hidden; background-color: transparent;'></iframe>",
  }) : super(key: key);
  String iframe;
  final Widget post;

  @override
  _AdvertisementState createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  @override
  Widget build(BuildContext context) {
    WebViewController web_controller = WebViewController();
    web_controller.loadHtmlString(widget.iframe);

    if (!kIsWeb) {
      web_controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      web_controller.setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          launchUrlString(request.url, mode: LaunchMode.externalApplication);
          return NavigationDecision.prevent;
        }
      ));
    }

    Widget advertisement = WebViewWidget(controller: web_controller);
    globals.scrolledPostsBetweenAds = 0;
    return Column(children: [SizedBox(width: Device.width, height: 24.h, child: Column(children: [Padding(padding: EdgeInsets.all(0), child: SizedBox(child: advertisement, width: Device.width, height: 24.h,)), Expanded(child: Padding(padding: EdgeInsets.all(0), child: widget.post))]))]);
  }
}
