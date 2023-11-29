import 'package:ovh.fso.dtubego/ui/widgets/AccountAvatar.dart';
import 'package:ovh.fso.dtubego/utils/Navigation/navigationShortcuts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:flutter/material.dart';

class UserListMobile extends StatefulWidget {
  UserListMobile(
      {Key? key,
      required this.userlist,
      required this.title,
      required this.showCount,
      required this.avatarSize})
      : super(key: key);
  final List<String> userlist;
  final String title;
  final bool showCount;
  final double avatarSize;

  @override
  State<UserListMobile> createState() => _UserListMobileState();
}

class _UserListMobileState extends State<UserListMobile> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _scrollController.animateTo(_scrollController.position.maxScrollExtent,        duration: Duration(milliseconds: 200), curve: Curves.easeOut);

    return Column(children: [
      Text(
          widget.title +
              (widget.showCount
                  ? " (" + widget.userlist.length.toString() + ")"
                  : ""),
          style: Theme.of(context).textTheme.headlineSmall),
      Padding(
        padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
        child: Container(
          height: widget.avatarSize + 3.h,
          width: double.infinity,
          child: ListView.builder(
              // controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.userlist.length,
              itemBuilder: (ctx, index) => Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: GestureDetector(
                      onTap: (() {
                        navigateToUserDetailPage(
                            context, widget.userlist[index], () {});
                      }),
                      child: Column(
                        children: [
                          AccountIconBase(
                            avatarSize: widget.avatarSize,
                            showVerified: true,
                            username: widget.userlist[index],
                            showBorder: true,
                          ),
                          Container(
                            height: 2.h,
                            width: widget.avatarSize,
                            child: Center(
                              child: Text(widget.userlist[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    ]);
  }
}
