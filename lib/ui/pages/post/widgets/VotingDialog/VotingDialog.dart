import 'package:ovh.fso.dtubego/ui/pages/post/widgets/VotingDialog/VotingDialogDesktop.dart';
import 'package:ovh.fso.dtubego/ui/pages/post/widgets/VotingDialog/VotingDialogMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:ovh.fso.dtubego/bloc/postdetails/postdetails_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:flutter/material.dart';

class VotingDialog extends StatelessWidget {
  VotingDialog(
      {Key? key,
      required this.author,
      required this.link,
      required this.downvote,
      required this.defaultVote,
      required this.defaultTip,
      //required this.currentVT,
      required this.isPost,
      this.vertical,
      this.verticalModeCallbackVotingButtonsPressed,
      this.okCallback,
      this.cancelCallback,
      required this.txBloc,
      required this.postBloc,
      required this.fixedDownvoteActivated,
      required this.fixedDownvoteWeight})
      : super(key: key);

  final String author;
  final String link;
  final double defaultVote;
  final double defaultTip;
  final double fixedDownvoteWeight;
  final bool fixedDownvoteActivated;
  // double currentVT;
  final bool isPost;
  final bool? vertical; // only used in moments for now

  final bool downvote;
  final VoidCallback? verticalModeCallbackVotingButtonsPressed;

  final VoidCallback? okCallback;
  final VoidCallback? cancelCallback;
  final TransactionBloc txBloc;
  final PostBloc postBloc;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: VotingDialogDesktop(
          author: author,
          link: link,
          downvote: downvote,
          defaultVote: defaultVote,
          defaultTip: defaultTip,
          isPost: isPost,
          txBloc: txBloc,
          postBloc: postBloc,
          fixedDownvoteActivated: fixedDownvoteActivated,
          fixedDownvoteWeight: fixedDownvoteWeight),
      tabletBody: VotingDialogDesktop(
          author: author,
          link: link,
          downvote: downvote,
          defaultVote: defaultVote,
          defaultTip: defaultTip,
          isPost: isPost,
          txBloc: txBloc,
          postBloc: postBloc,
          fixedDownvoteActivated: fixedDownvoteActivated,
          fixedDownvoteWeight: fixedDownvoteWeight),
      mobileBody: VotingDialogMobile(
          author: author,
          link: link,
          downvote: downvote,
          defaultVote: defaultVote,
          defaultTip: defaultTip,
          isPost: isPost,
          txBloc: txBloc,
          postBloc: postBloc,
          fixedDownvoteActivated: fixedDownvoteActivated,
          fixedDownvoteWeight: fixedDownvoteWeight),
    );
  }
}
