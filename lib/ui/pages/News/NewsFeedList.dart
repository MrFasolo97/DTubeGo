import 'package:ovh.fso.dtubego/ui/pages/News/Layouts/NewsListDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/News/Layouts/NewsListMobile.dart';
import 'package:ovh.fso.dtubego/bloc/feed/feed_bloc_full.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

typedef Bool2VoidFunc = void Function(bool);
typedef ListOfString2VoidFunc = void Function(List<String>);

class NewsFeedList extends StatelessWidget {
  List<FeedItem> newsList;

  late YoutubePlayerController _youtubePlayerController;

  NewsFeedList({
    required this.newsList,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        desktopBody: NewsListDesktop(
            feed: newsList,
            bigThumbnail: true,
            context: context,
            crossAxisCount: 4),
        mobileBody: NewsListMobile(
            feed: newsList, bigThumbnail: true, context: context),
        tabletBody: NewsListDesktop(
            feed: newsList,
            bigThumbnail: true,
            context: context,
            crossAxisCount: 2));
  }
}
