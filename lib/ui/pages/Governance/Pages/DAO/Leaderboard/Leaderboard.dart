import 'package:ovh.fso.dtubego/ui/pages/Governance/Pages/DAO/Leaderboard/Layouts/LeaderboardDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/Governance/Pages/DAO/Leaderboard/Layouts/LeaderboardMobile.dart';
import 'package:ovh.fso.dtubego/ui/pages/Governance/Pages/DAO/Leaderboard/Layouts/LeaderboardTablet.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: LeaderboardDesktop(),
      mobileBody: LeaderboardMobile(),
      tabletBody: LeaderboardTablet(),
    );
  }
}
