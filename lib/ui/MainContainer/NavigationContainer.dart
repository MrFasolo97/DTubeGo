import 'package:ovh.fso.dtubego/ui/MainContainer/MainScaffolds/DesktopScaffold.dart';
import 'package:ovh.fso.dtubego/ui/MainContainer/MainScaffolds/MobileScaffold.dart';

import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class NavigationContainer extends StatelessWidget {
  const NavigationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: DesktopScaffold(),
      mobileBody: MobileScaffold(),
      tabletBody: DesktopScaffold(),
    );
  }
}
