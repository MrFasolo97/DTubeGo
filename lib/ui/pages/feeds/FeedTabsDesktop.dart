import 'package:ovh.fso.dtubego/ui/pages/feeds/lists/Widgets/TabBarWithPosition.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;

import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/pages/feeds/FeedTabContainer.dart';
import 'package:ovh.fso.dtubego/ui/pages/feeds/FeedViewBase.dart';
import 'package:ovh.fso.dtubego/ui/widgets/OverlayWidgets/OverlayText.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FeedTabsDesktop extends StatelessWidget {
  const FeedTabsDesktop({
    Key? key,
    required this.tabBarFeedItemList,
    required this.tabController,
    required this.tabIcons,
    required this.tabNames,
    required this.selectedIndex,
  }) : super(key: key);

  final List<FeedViewBase> tabBarFeedItemList;
  final TabController tabController;
  final List<IconData> tabIcons;
  final List<String> tabNames;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TabBarView(
          children: tabBarFeedItemList,
          controller: tabController,
        ),
        TabBarWithPosition(
          tabIcons: tabIcons,
          iconSize: globalIconSizeMedium,
          tabController: tabController,
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 40),
          tabNames: tabNames,
          showLabels: true,
          menuSize: globals.keyPermissions.isEmpty ? 200 : 250,
        ),
      ],
    );
  }
}
