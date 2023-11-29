import 'package:ovh.fso.dtubego/ui/MainContainer/Widgets/AboutDialog/AboutDialogDesktop.dart';
import 'package:ovh.fso.dtubego/ui/MainContainer/Widgets/AboutDialog/AboutDialogMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class AboutAppDialog extends StatelessWidget {
  const AboutAppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: AboutDialogDesktop(),
      tabletBody: AboutDialogDesktop(),
      mobileBody: AboutDialogMobile(),
    );
  }
}
