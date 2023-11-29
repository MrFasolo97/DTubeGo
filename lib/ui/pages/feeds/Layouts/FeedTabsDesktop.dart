import 'package:ovh.fso.dtubego/ui/pages/feeds/lists/Widgets/TabBarWithPosition.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;

import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/pages/feeds/FeedViewBase.dart';
import 'package:flutter/material.dart';

class FeedTabsDesktop extends StatelessWidget {
  const FeedTabsDesktop({
    Key? key,
    required this.tabBarFeedItemList,
    required this.tabBarFeedItemListUnsignedLogin,
    required this.tabController,
    required this.tabIcons,
    required this.tabNames,
    required this.tabIconsUnsignedLogin,
    required this.tabNamesUnsignedLogin,
    required this.selectedIndex,
  }) : super(key: key);

  final List<FeedViewBase> tabBarFeedItemList;
  final List<FeedViewBase> tabBarFeedItemListUnsignedLogin;
  final TabController tabController;
  final List<IconData> tabIcons;
  final List<String> tabNames;
  final List<IconData> tabIconsUnsignedLogin;
  final List<String> tabNamesUnsignedLogin;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 80),
          child: TabBarView(
            children: globals.keyPermissions.isEmpty
                ? tabBarFeedItemListUnsignedLogin
                : tabBarFeedItemList,
            controller: tabController,
          ),
        ),
        TabBarWithPosition(
          tabIcons:
              globals.keyPermissions.isEmpty ? tabIconsUnsignedLogin : tabIcons,
          iconSize: globalIconSizeBig,
          tabController: tabController,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 0),
          tabNames:
              globals.keyPermissions.isEmpty ? tabNamesUnsignedLogin : tabNames,
          showLabels: true,
          menuSize: globals.keyPermissions.isEmpty ? 200 : 250,
        ),
      ],
    );
  }
}
