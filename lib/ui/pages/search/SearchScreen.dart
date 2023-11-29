import 'package:ovh.fso.dtubego/ui/pages/search/Layouts/SearchScreenDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/search/Layouts/SearchScreenMobile.dart';
import 'package:ovh.fso.dtubego/ui/pages/search/Layouts/SearchScreenTablet.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ResponsiveLayout(
      desktopBody: SearchScreenDesktop(),
      tabletBody: SearchScreenTablet(),
      mobileBody: SearchScreenMobile(),
    );
  }

}
