import 'package:ovh.fso.dtubego/ui/widgets/Suggestions/SuggestedChannels/SuggestedChannelsDesktop.dart';
import 'package:ovh.fso.dtubego/ui/widgets/Suggestions/SuggestedChannels/SuggestedChannelsMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

class SuggestedChannels extends StatelessWidget {
  SuggestedChannels({Key? key, required this.avatarSize, this.crossAxisCount})
      : super(key: key);
  final double avatarSize;

  int? crossAxisCount;
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: SuggestedChannelsDesktop(
        avatarSize: avatarSize,
        crossAxisCount: crossAxisCount != null ? crossAxisCount! : 1,
      ),
      mobileBody: SuggestedChannelsMobile(avatarSize: avatarSize),
      tabletBody: SuggestedChannelsDesktop(
        avatarSize: avatarSize,
        crossAxisCount: crossAxisCount != null ? crossAxisCount! : 1,
      ),
    );
  }
}
