import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/widgets/dtubeLogoPulse/DTubeLogo.dart';
import 'package:flutter/material.dart';

AppBar dtubeSubAppBarMobile(
    bool showLogo, String title, BuildContext context, List<Widget>? actions) {
  return AppBar(
    centerTitle: true,
    backgroundColor: globalBGColor,
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        showLogo
            ? DTubeLogo(
                size: 30,
              )
            : SizedBox(
                width: 0,
              ),
        title != ""
            ? Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              )
            : SizedBox(
                width: 0,
              ),
      ],
    ),
    actions: actions,
  );
}
