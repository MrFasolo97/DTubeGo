import 'package:dtube_go/bloc/user/user_bloc_full.dart';
import 'package:dtube_go/ui/pages/user/Widgets/MoreInfoButton/UsersMoreInfoButtonDesktop.dart';
import 'package:dtube_go/ui/pages/user/Widgets/MoreInfoButton/UsersMoreInfoButtonMobile.dart';
import 'package:dtube_go/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class UserMoreInfoButton extends StatelessWidget {
  UserMoreInfoButton(
      {Key? key, required this.context, required this.user, this.size})
      : super(key: key);

  final BuildContext context;
  final User user;
  double? size;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: UserMoreInfoButtonMobile(context: context, user: user),
        tabletBody: UserMoreInfoButtonDesktop(context: context, user: user),
        desktopBody: UserMoreInfoButtonDesktop(context: context, user: user));
  }
}
