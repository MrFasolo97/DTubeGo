import 'package:ovh.fso.dtubego/ui/pages/user/Pages/Layouts/ProfileSettingsDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/user/Pages/Layouts/ProfileSettingsMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_bloc.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_bloc_full.dart';
import 'package:flutter/material.dart';

class ProfileSettingsContainer extends StatelessWidget {
  ProfileSettingsContainer({Key? key, required this.userBloc})
      : super(key: key);
  final UserBloc userBloc;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: ProfileSettingsDesktop(userBloc: userBloc),
      tabletBody: ProfileSettingsDesktop(userBloc: userBloc),
      mobileBody: ProfileSettingsMobile(userBloc: userBloc),
    );
  }
}
