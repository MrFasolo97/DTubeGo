import 'package:dtube_go/ui/pages/Explore/GenreFeed/Layouts/GenreFeedDesktop.dart';
import 'package:dtube_go/ui/pages/Explore/GenreFeed/Layouts/GenreFeedMobile.dart';
import 'package:dtube_go/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

typedef Bool2VoidFunc = void Function(bool);

class GenreFeed extends StatelessWidget {
  const GenreFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: GenreFeedDesktop(),
      tabletBody: GenreFeedDesktop(),
      mobileBody: GenreFeedMobile(),
    );
  }
}
