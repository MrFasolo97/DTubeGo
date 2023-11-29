import 'package:ovh.fso.dtubego/ui/widgets/Suggestions/UserListDesktop.dart';
import 'package:ovh.fso.dtubego/ui/widgets/Suggestions/UserListMobile.dart';
import 'package:ovh.fso.dtubego/ui/widgets/Suggestions/UserListTablet.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  UserList(
      {Key? key,
      required this.userlist,
      required this.title,
      required this.showCount,
      required this.avatarSize,
      this.crossAxisCount})
      : super(key: key);
  final List<String> userlist;
  final String title;
  final bool showCount;
  final double avatarSize;

  int? crossAxisCount;
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: UserListDesktop(
          userlist: userlist,
          title: title,
          showCount: showCount,
          crossAxisCount: crossAxisCount != null ? crossAxisCount! : 3,
          avatarSize: avatarSize),
      mobileBody: UserListMobile(
          userlist: userlist,
          title: title,
          showCount: showCount,
          avatarSize: avatarSize),
      tabletBody: UserListTablet(
          userlist: userlist,
          title: title,
          showCount: showCount,
          crossAxisCount: crossAxisCount != null ? crossAxisCount! : 3,
          avatarSize: avatarSize),
    );
  }
}
