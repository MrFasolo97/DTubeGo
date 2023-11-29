import 'package:ovh.fso.dtubego/ui/pages/notifications/Layouts/NotificationsDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/notifications/Layouts/NotificationsMobile.dart';
import 'package:ovh.fso.dtubego/ui/pages/notifications/Layouts/NotificationsTablet.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: NotificationsDesktop(),
      tabletBody: NotificationsTablet(),
      mobileBody: NotificationsMobile(),
    );
  }
}
