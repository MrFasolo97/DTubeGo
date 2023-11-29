import 'package:ovh.fso.dtubego/ui/widgets/Comments/Layouts/CommentDialogDesktop.dart';
import 'package:ovh.fso.dtubego/ui/widgets/Comments/Layouts/CommentDialogMobile.dart';
import 'package:ovh.fso.dtubego/utils/Layout/ResponsiveLayout.dart';
import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:flutter/material.dart';

class CommentDialog extends StatelessWidget {
  CommentDialog(
      {Key? key,
      required this.originAuthor,
      required this.txBloc,
      required this.originLink,
      required this.defaultCommentVote,
      this.okCallback,
      this.cancelCallback})
      : super(key: key);
  final TransactionBloc txBloc;
  final String originAuthor;
  final String originLink;
  final double defaultCommentVote;
  final VoidCallback? okCallback;
  final VoidCallback? cancelCallback;

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      desktopBody: CommentDialogDesktop(
          originAuthor: originAuthor,
          txBloc: txBloc,
          originLink: originLink,
          defaultCommentVote: defaultCommentVote),
      tabletBody: CommentDialogDesktop(
          originAuthor: originAuthor,
          txBloc: txBloc,
          originLink: originLink,
          defaultCommentVote: defaultCommentVote),
      mobileBody: CommentDialogMobile(
          originAuthor: originAuthor,
          txBloc: txBloc,
          originLink: originLink,
          defaultCommentVote: defaultCommentVote),
    );
  }
}
