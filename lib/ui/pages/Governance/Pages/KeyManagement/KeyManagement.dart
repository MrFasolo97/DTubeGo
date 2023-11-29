import 'package:ovh.fso.dtubego/ui/pages/Governance/Pages/KeyManagement/Layouts/KeyManagementDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/Governance/Pages/KeyManagement/Layouts/KeyManagementMobile.dart';
import 'package:ovh.fso.dtubego/ui/pages/Governance/Pages/KeyManagement/Layouts/KeyManagementTablet.dart';

export 'package:ovh.fso.dtubego/bloc/auth/auth_repository.dart';

import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';

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
