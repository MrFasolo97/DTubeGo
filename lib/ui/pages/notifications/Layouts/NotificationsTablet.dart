import 'package:ovh.fso.dtubego/ui/pages/notifications/NotificationItem/NotificationItemDesktop.dart';
import 'package:ovh.fso.dtubego/ui/widgets/AppBar/DTubeSubAppBarDesktop.dart';
import 'package:ovh.fso.dtubego/ui/widgets/dtubeLogoPulse/dtubeLoading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/utils/Navigation/navigationShortcuts.dart';
import 'package:ovh.fso.dtubego/bloc/notification/notification_bloc_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsTablet extends StatefulWidget {
  @override
  _NotificationsTabletState createState() => _NotificationsTabletState();

  NotificationsTablet({Key? key}) : super(key: key);
}

class _NotificationsTabletState extends State<NotificationsTablet> {
  late NotificationBloc notificationBloc;
  late int lastNotification;

  @override
  void initState() {
    super.initState();
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    notificationBloc.add(FetchNotificationsEvent([])); // statements;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dtubeSubAppBarDesktop(true, "Notification", context, null),
      body: Container(
        child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationInitialState) {
              return buildLoading();
            } else if (state is NotificationLoadingState) {
              return buildLoading();
            } else if (state is NotificationLoadedState) {
              return NotificationTabContainer(
                  notifications: state.notifications, username: state.username);
            } else if (state is NotificationErrorState) {
              return buildErrorUi(state.message);
            } else {
              return buildErrorUi('test');
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: DtubeLogoPulseWithSubtitle(
          subtitle: "Loading your notifications...", size: 10.w),
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
}

class NotificationTabContainer extends StatefulWidget {
  const NotificationTabContainer({
    Key? key,
    required this.notifications,
    required this.username,
  }) : super(key: key);

  final List<AvalonNotification> notifications;
  final String username;

  @override
  State<NotificationTabContainer> createState() =>
      _NotificationTabContainerState();
}

class _NotificationTabContainerState extends State<NotificationTabContainer>
    with SingleTickerProviderStateMixin {
  List<String> _tabNames = [
    "all",
    "comments",
    "mentions",
    "votes",
    "transfers",
    "others"
  ];
  List<AvalonNotification> _voteNotifications = [];
  List<AvalonNotification> _commentNotifications = [];
  List<AvalonNotification> _mentionsNotifications = [];
  List<AvalonNotification> _transferNotifications = [];
  List<AvalonNotification> _otherNotifications = [];
  late TabController _tabController;
  late String _currentUserName;

  @override
  void initState() {
    for (var n in widget.notifications) {
      if ([5, 19].contains(n.tx.type)) {
        // votes || tipped votes
        _voteNotifications.add(n);
      } else if ([4, 13].contains(n.tx.type)) {
        // comment || promoted comment || mentions
        if (n.tx.data.pa == widget.username) {
          _commentNotifications.add(n);
        } else {
          _mentionsNotifications.add(n);
        }
      } else if (n.tx.type == 3) {
        // transfers
        _transferNotifications.add(n);
      } else {
        _otherNotifications.add(n);
      }
    }
    _tabController = new TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: globalAlmostWhite,
            indicatorColor: globalRed,
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
            tabs: [
              Tab(
                text: _tabNames[0],
              ),
              Tab(
                text: _tabNames[1] +
                    ' (' +
                    _commentNotifications.length.toString() +
                    ')',
              ),
              Tab(
                text: _tabNames[2] +
                    ' (' +
                    _mentionsNotifications.length.toString() +
                    ')',
              ),
              Tab(
                text: _tabNames[3] +
                    ' (' +
                    _voteNotifications.length.toString() +
                    ')',
              ),
              Tab(
                text: _tabNames[4] +
                    ' (' +
                    _transferNotifications.length.toString() +
                    ')',
              ),
              Tab(
                text: _tabNames[5] +
                    ' (' +
                    _otherNotifications.length.toString() +
                    ')',
              ),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        Container(
          width: 100.w,
          height: 80.h,
          child: TabBarView(
            children: [
              buildNotificationList(widget.notifications, _tabNames[0]),
              buildNotificationList(_commentNotifications, _tabNames[1]),
              buildNotificationList(_mentionsNotifications, _tabNames[2]),
              buildNotificationList(_voteNotifications, _tabNames[3]),
              buildNotificationList(_transferNotifications, _tabNames[4]),
              buildNotificationList(_otherNotifications, _tabNames[5]),
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }

  Widget buildNotificationList(
      List<AvalonNotification> notifications, String notificationType) {
    List<int> navigatableTxsUser = [1, 2, 3, 7, 8];
    List<int> navigatableTxsPost = [4, 5, 13, 19];
    if (notifications.length > 0) {
      return MasonryGridView.count(
        crossAxisCount: 3,
        itemCount: notifications.length,
        itemBuilder: (ctx, pos) {
          bool _userNavigationPossible =
              navigatableTxsUser.contains(notifications[pos].tx.type);
          bool _postNavigationPossible =
              navigatableTxsPost.contains(notifications[pos].tx.type);

          return InkWell(
            child: NotificationItemTablet(
                sender: notifications[pos].tx.sender,
                tx: notifications[pos].tx,
                username: widget.username,
                userNavigation: _userNavigationPossible,
                postNavigation: _postNavigationPossible,
                notificationType: notificationType),
            onTap: () {
              if (_userNavigationPossible) {
                navigateToUserDetailPage(
                    context, notifications[pos].tx.sender, () {});
              }
              if (_postNavigationPossible) {
                navigateToPostDetailPage(
                    context,
                    notifications[pos].tx.data.author! != ""
                        ? notifications[pos].tx.data.author!
                        : notifications[pos].tx.sender,
                    notifications[pos].tx.data.link!,
                    "none",
                    false,
                    () {});
              }
            },
          );
        },
      );
    } else {
      return Center(
        child: Text("you dont have any notifications yet",
            style: Theme.of(context).textTheme.headlineSmall),
      );
    }
  }
}
