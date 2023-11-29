// dialog to show current app version and build

import 'package:ovh.fso.dtubego/res/Config/appConfigValues.dart';
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/widgets/DialogTemplates/DialogWithTitleLogo.dart';
import 'package:ovh.fso.dtubego/ui/widgets/dtubeLogoPulse/DTubeLogo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDialogDesktop extends StatefulWidget {
  const AboutDialogDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<AboutDialogDesktop> createState() => _AboutDialogDesktopState();
}

class _AboutDialogDesktopState extends State<AboutDialogDesktop> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopUpDialogWithTitleLogo(
      titleWidgetPadding: 5.w,
      titleWidgetSize: 20.w,
      callbackOK: () {},
      titleWidget: FaIcon(
        FontAwesomeIcons.question,
        size: 50,
        color: globalBGColor,
      ),
      showTitleWidget: true,
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Version',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                        _packageInfo.version +
                            ' (Build: ' +
                            _packageInfo.buildNumber +
                            ')',
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'App Development Team',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Main Developer: @MrFasolo97 / @fasolo97",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Former Main Developer: @tibfox",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "iOS Developer: @no-do-not-track-me",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "API extensions: @brishtiteveja0595",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      'Avalon Blockchain',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        width: 25.w,
                        child: Text(
                          "This app is running on the Avalon blockchain and is highly inspired by the website d.tube.",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        launchUrl(Uri.parse(AppConfig.gitDtubeUrl));
                      },
                      child: Row(
                        children: [
                          Text("DTube on ",
                              style: Theme.of(context).textTheme.bodyLarge),
                          FaIcon(FontAwesomeIcons.github, size: 20),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        launchUrl(Uri.parse(AppConfig.gitAvalonUrl));
                      },
                      child: Row(
                        children: [
                          Text("Avalon on ",
                              style: Theme.of(context).textTheme.bodyLarge),
                          FaIcon(FontAwesomeIcons.github, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 1.h, left: 22.w, right: 22.w),
                child: ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse(AppConfig.faqUrl));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        DTubeLogo(size: 8.w),
                        Text(
                          "FAQ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    )),
              ),
              InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: globalRed,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: Text(
                      "Thanks",
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        },
      ),
    );
  }
}
