import 'package:ovh.fso.dtubego/ui/pages/settings/Layouts/SettingsTabContainerDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/settings/Layouts/SettingsTabContainerMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class SettingsTabContainer extends StatelessWidget {
  const SettingsTabContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: SettingsTabContainerDesktop(),
      tabletBody: SettingsTabContainerDesktop(),
      mobileBody: SettingsTabContainerMobile(),
    );
  }
}
