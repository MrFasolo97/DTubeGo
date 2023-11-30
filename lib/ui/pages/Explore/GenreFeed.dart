import 'package:ovh.fso.dtubego/ui/pages/Explore/GenreFeed/Layouts/GenreFeedDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/Explore/GenreFeed/Layouts/GenreFeedMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:flutter/material.dart';

typedef Bool2VoidFunc = void Function(bool);

class GenreFeed extends StatelessWidget {
  const GenreFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return ResponsiveLayout(
      desktopBody: GenreFeedDesktop(),
      tabletBody: GenreFeedDesktop(),
      mobileBody: GenreFeedMobile(),
=======
    return FutureBuilder<bool>(
        future: getDisplayModes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return buildLoading(context);
          } else {
            return Container(
              height: 100.h,
              child: Stack(
                children: [
                  BlocBuilder<FeedBloc, FeedState>(
                    builder: (context, state) {
                      if (state is FeedInitialState ||
                          state is FeedLoadingState) {
                        _feedItems = [];
                        return buildLoading(context);
                      } else if (state is FeedLoadedState) {
                        _feedItems = [];
                        _feedItems.addAll(state.feed);
                        BlocProvider.of<FeedBloc>(context).isFetching = false;
                      } else if (state is FeedErrorState) {
                        return buildErrorUi(state.message);
                      }
                      return buildPostList(_feedItems, context);
                    },
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget buildLoading(BuildContext context) {
    return Container(
      height: 100.h,
      child: DtubeLogoPulseWithSubtitle(
        subtitle: "loading posts..",
        size: 40.w,
      ),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildPostList(List<FeedItem> feed, BuildContext context) {
    return ListView.builder(
      // controller: _scrollController
      //   ..addListener(() {
      //     if (_scrollController.offset >=
      //             _scrollController.position.maxScrollExtent &&
      //         !BlocProvider.of<FeedBloc>(context).isFetching) {
      //       BlocProvider.of<FeedBloc>(context)
      //         ..isFetching = true
      //         ..add(FetchFeedEvent(
      //             feedType: "HotFeed",
      //             fromAuthor: feed[feed.length - 1].author,
      //             fromLink: feed[feed.length - 1].link));
      //     }

      //     if (_scrollController.offset <=
      //             _scrollController.position.minScrollExtent &&
      //         !BlocProvider.of<FeedBloc>(context).isFetching) {
      //       _feedItems.clear();
      //       if (widget.searchTags != "") {
      //         BlocProvider.of<FeedBloc>(context)
      //           ..isFetching = true
      //           ..add(FetchTagSearchResults(tags: widget.searchTags));
      //       } else {
      //         BlocProvider.of<FeedBloc>(context)
      //           ..isFetching = true
      //           ..add(FetchFeedEvent(feedType: "HotFeed"));
      //       }
      //     }
      //   }),
      padding: EdgeInsets.only(top: 19.h),
      itemCount: feed.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          navigateToPostDetailPage(context, feed[index].author,
              feed[index].link, "none", false, () {});
        },
        child: (feed[index].summaryOfVotes < 0 ||
                feed[index].jsonString?.hide == 1 ||
                feed[index].jsonString?.nsfw == 1)
            ? SizedBox(
                height: 0,
              )
            : new CachedNetworkImage(
                imageUrl: feed[index].thumbUrl,
                placeholder: (context, url) => Container(
                    //width: widget.avatarSize,
                    height: 15.h,
                    child: Container(
                      height: 10.h,
                      child: DTubeLogoPulse(
                        size: 10.h,
                      ),
                    )),
                errorWidget: (context, url, error) => Container(
                    color: globalBGColor,
                    //width: widget.avatarSize,
                    height: 20.h,
                    child: Container(
                        height: 10.h,
                        child: Image.asset(
                          'assets/images/dtube_logo_white.png',
                          fit: BoxFit.fitHeight,
                        ))),
              ),
      ),
>>>>>>> master
    );
  }
}
