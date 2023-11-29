import 'package:ovh.fso.dtubego/ui/pages/upload/UploadForm/uploadFormDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/UploadForm/uploadFormMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/PresetSelection/Widgets/PresetCards.dart';
import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:flutter/material.dart';

class UploadForm extends StatelessWidget {
  UploadForm(
      {Key? key,
      required this.uploadData,
      required this.callback,
      required this.preset})
      : super(key: key);

  final UploadData uploadData;
  final Function(UploadData) callback;
  final Preset preset;
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: UploadFormDesktop(
          uploadData: uploadData, callback: callback, preset: preset),
      tabletBody: UploadFormDesktop(
          uploadData: uploadData, callback: callback, preset: preset),
      mobileBody: UploadFormMobile(
          uploadData: uploadData, callback: callback, preset: preset),
    );
  }
}
