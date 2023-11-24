import 'package:dtube_go/ui/pages/upload/Layouts/UploaderMainPageDesktop.dart';
import 'package:dtube_go/ui/pages/upload/Layouts/UploaderMainPageMobile.dart';
import 'package:dtube_go/ui/pages/upload/PresetSelection/Widgets/PresetCards.dart';
import 'package:dtube_go/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class UploaderMainPage extends StatelessWidget {
  UploaderMainPage({Key? key, required this.callback, required this.preset})
      : super(key: key);

  final VoidCallback callback;
  final Preset preset;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: UploaderMainPageDesktop(callback: callback, preset: preset),
      tabletBody: UploaderMainPageDesktop(callback: callback, preset: preset),
      mobileBody: UploaderMainPageMobile(callback: callback, preset: preset),
    );
  }
}
