import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:ovh.fso.dtubego/utils/Widgets/QRCodeDialog/Layouts/QRCodeDialogDesktop.dart';
import 'package:ovh.fso.dtubego/utils/Widgets/QRCodeDialog/Layouts/QRCodeDialogMobile.dart';
import 'package:flutter/material.dart';


class QRCodeDialog extends StatelessWidget {
  const QRCodeDialog({Key? key, required this.code}) : super(key: key);
  final String code;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: QRCodeDialogDesktop(code: code),
      tabletBody: QRCodeDialogDesktop(code: code),
      mobileBody: QRCodeDialogMobile(code: code),
    );
  }
}
