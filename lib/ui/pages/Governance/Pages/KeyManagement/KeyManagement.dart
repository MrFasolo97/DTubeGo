import 'package:dtube_go/ui/pages/Governance/Pages/KeyManagement/Layouts/KeyManagementDesktop.dart';
import 'package:dtube_go/ui/pages/Governance/Pages/KeyManagement/Layouts/KeyManagementMobile.dart';
import 'package:dtube_go/ui/pages/Governance/Pages/KeyManagement/Layouts/KeyManagementTablet.dart';

export 'package:dtube_go/bloc/auth/auth_repository.dart';

import 'package:dtube_go/utils/Layout/ResponsiveLayout.dart';

import 'package:flutter/material.dart';

class KeyManagementPage extends StatelessWidget {
  const KeyManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: KeyManagementDesktop(),
      mobileBody: KeyManagementMobile(),
      tabletBody: KeyManagementTablet(),
    );
  }
}
