import 'package:ovh.fso.dtubego/bloc/feed/feed_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/search/search_bloc_full.dart';
import 'package:ovh.fso.dtubego/ui/MainContainer/Widgets/AboutDialog/AboutDialog.dart';
import 'package:ovh.fso.dtubego/ui/pages/search/SearchScreen.dart';
import 'package:ovh.fso.dtubego/bloc/settings/settings_bloc_full.dart';

import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/pages/settings/SettingsTabContainer.dart';
import 'package:ovh.fso.dtubego/ui/pages/Governance/GovernanceTabContainer.dart';
import 'package:ovh.fso.dtubego/ui/widgets/OverlayWidgets/OverlayIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildMainMenuSpeedDial(BuildContext context) {
  List<SpeedDialChild> mainMenuButtonOptions = [
    SpeedDialChild(
        child: ShadowedIcon(
            icon: FontAwesomeIcons.magnifyingGlass,
            color: globalAlmostWhite,
            shadowColor: Colors.black,
            size: globalIconSizeBig),
        foregroundColor: globalAlmostWhite,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MultiBlocProvider(providers: [
              BlocProvider<SearchBloc>(
                  create: (context) =>
                      SearchBloc(repository: SearchRepositoryImpl())),
              BlocProvider(
                  create: (context) =>
                      FeedBloc(repository: FeedRepositoryImpl())),
            ], child: SearchScreen());
          }));
        }),
    SpeedDialChild(
        child: ShadowedIcon(
            icon: FontAwesomeIcons.hotel,
            color: globalAlmostWhite,
            shadowColor: Colors.black,
            size: globalIconSizeBig),
        foregroundColor: globalAlmostWhite,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return GovernanceMainPage();
          }));
        }),
    SpeedDialChild(
        child: ShadowedIcon(
            icon: FontAwesomeIcons.question,
            color: globalAlmostWhite,
            shadowColor: Colors.black,
            size: globalIconSizeBig),
        foregroundColor: globalAlmostWhite,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AboutAppDialog();
              });
        }),
    SpeedDialChild(
        child: ShadowedIcon(
            icon: FontAwesomeIcons.gear,
            color: globalAlmostWhite,
            shadowColor: Colors.black,
            size: globalIconSizeBig),
        foregroundColor: globalAlmostWhite,
        elevation: 0,
        backgroundColor: Colors.transparent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider<SettingsBloc>(
                create: (context) => SettingsBloc(),
                child: SettingsTabContainer());
          }));
        }),
  ];

  return SpeedDial(
      child: ShadowedIcon(
          icon: FontAwesomeIcons.bars,
          color: globalAlmostWhite,
          shadowColor: Colors.black,
          size: globalIconSizeMedium),
      activeIcon: FontAwesomeIcons.chevronLeft,
      direction: SpeedDialDirection.down,
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'menu',
      heroTag: 'main menu button',
      backgroundColor: Colors.transparent,
      foregroundColor: globalAlmostWhite,
      elevation: 0.0,
      shape: CircleBorder(),
      gradientBoxShape: BoxShape.circle,
      children: mainMenuButtonOptions);
}
