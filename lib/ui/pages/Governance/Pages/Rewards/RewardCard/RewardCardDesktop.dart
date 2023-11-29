import 'package:ovh.fso.dtubego/bloc/rewards/rewards_bloc_full.dart';
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/pages/post/postDetailPage.dart';
import 'package:ovh.fso.dtubego/ui/widgets/AccountAvatar.dart';
import 'package:ovh.fso.dtubego/ui/widgets/dtubeLogoPulse/DTubeLogo.dart';
import 'package:ovh.fso.dtubego/ui/widgets/system/ColorChangeCircularProgressIndicator.dart';
import 'package:ovh.fso.dtubego/utils/Strings/friendlyTimestamp.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;

import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RewardCardDesktop extends StatefulWidget {
  RewardCardDesktop(
      {Key? key, required this.reward, required this.parentWidget})
      : super(key: key);

  final Reward reward;
  final Widget parentWidget;

  @override
  _RewardCardDesktopState createState() => _RewardCardDesktopState();
}

class _RewardCardDesktopState extends State<RewardCardDesktop>
    with AutomaticKeepAliveClientMixin {
  double widthLabel = 100;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateToPostDetailPage(
            context, widget.reward.author, widget.reward.link);
      },
      child: Card(
        color: globalBlue,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AccountIconBase(
                      username: widget.reward.author,
                      avatarSize: 50,
                      showVerified: true,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: AccountNameBase(
                        username: widget.reward.author,
                        width: 100,
                        height: 50,
                        mainStyle: Theme.of(context).textTheme.headlineSmall!,
                        subStyle: Theme.of(context).textTheme.bodyLarge!,
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "content:",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "spent:",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "voted on:",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          "published on:",
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            widget.reward.author + '/' + widget.reward.link,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            (widget.reward.vt / 1000).toStringAsFixed(2) + 'K',
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            DateTime.fromMillisecondsSinceEpoch(
                                    widget.reward.ts)
                                .toLocal()
                                .toString()
                                .substring(0, 16),
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            DateTime.fromMillisecondsSinceEpoch(
                                    widget.reward.contentTs)
                                .toLocal()
                                .toString()
                                .substring(0, 16),
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                    // width: 100,
                    height: 50,
                    child: widget.reward.claimed == null &&
                            timestampGreater7Days(widget.reward.ts)
                        ? BlocProvider(
                            // gets its own tranactionbloc to avoid spamming snackbars
                            create: (context) => TransactionBloc(
                                repository: TransactionRepositoryImpl()),
                            child: ClaimRewardButton(
                              author: widget.reward.author,
                              claimable: widget.reward.claimable,
                              link: widget.reward.link,
                              topLevelWidget: widget.parentWidget,
                            ),
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (widget.reward.claimable / 100)
                                    .toStringAsFixed(2),
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: DTubeLogoShadowed(size: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  (widget.reward.claimed == null
                                          ? "claimable "
                                          : "claimed ") +
                                      (widget.reward.claimed != null
                                          ? TimeAgo.timeInAgoTS(
                                              widget.reward.claimed!)
                                          : TimeAgo.timeAgoClaimIn(
                                              widget.reward.ts)),
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ],
                          ))
              ]),
        ),
      ),
    );
  }

  void navigateToPostDetailPage(
      BuildContext context, String author, String link) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PostDetailPage(
        author: author,
        link: link,
        recentlyUploaded: false,
        directFocus: "none",
      );
    }));
  }
}

class ClaimRewardButton extends StatefulWidget {
  ClaimRewardButton(
      {Key? key,
      required this.author,
      required this.link,
      required this.claimable,
      required this.topLevelWidget})
      : super(key: key);

  final String author;
  final String link;
  final double claimable;
  final Widget topLevelWidget;

  @override
  _ClaimRewardButtonState createState() => _ClaimRewardButtonState();
}

class _ClaimRewardButtonState extends State<ClaimRewardButton> {
  late TransactionBloc _txBloc;

  @override
  void initState() {
    super.initState();
    _txBloc = BlocProvider.of<TransactionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      if (state is TransactionSent) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'claimed ' + (widget.claimable / 100).toStringAsFixed(2),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: DTubeLogoShadowed(size: 20),
            ),
          ],
        );
      } else {
        if (state is TransactionSinging || state is TransactionSigned) {
          return ColorChangeCircularProgressIndicator();
        } else {
          return ElevatedButton(
            onPressed: !globals.keyPermissions.contains(17)
                ? null
                : () {
                    TxData txdata = TxData(
                      author: widget.author,
                      link: widget.link,
                    );
                    Transaction newTx = Transaction(type: 17, data: txdata);
                    _txBloc.add(SignAndSendTransactionEvent(tx: newTx));
                  },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'claim ' + (widget.claimable / 100).toStringAsFixed(2),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: DTubeLogoShadowed(size: 30),
                ),
              ],
            ),
          );
        }
      }
    });
  }
}
