import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/widgets/DialogTemplates/DialogWithTitleLogo.dart';
import 'package:ovh.fso.dtubego/utils/Widgets/CountDownTimer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HivePostCooldownDetectedDialog extends StatefulWidget {
  HivePostCooldownDetectedDialog({Key? key, required this.cooldown})
      : super(key: key);

  final int cooldown;

  @override
  State<HivePostCooldownDetectedDialog> createState() =>
      _HivePostCooldownDetectedDialogState();
}

class _HivePostCooldownDetectedDialogState
    extends State<HivePostCooldownDetectedDialog> {
  bool timerHasStopped = false;

  @override
  Widget build(BuildContext context) {
    return PopUpDialogWithTitleLogo(
        showTitleWidget: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Please wait a bit!",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
                SizedBox(height: 2.h),
                Text(
                    "You want to cross post to hive but you already have posted something within the last 5 minutes.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Please wait ", // 5 min hive cooldown to expire and try it again.",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center),
                    CountDownTimer(
                      secondsRemaining: widget.cooldown,
                      whenTimeExpires: () {
                        setState(() {
                          timerHasStopped = true;
                        });
                      },
                      countDownTimerStyle: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: globalRed),
                    ),
                  ],
                ),
                Text("to expire and try it again.",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center),
                SizedBox(height: 3.h),
                Text(
                    "This cooldown is a property coming from the hive blockchain. We just want to avoid upload errors when you crosspost.",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: globalRed),
                    textAlign: TextAlign.center),
                SizedBox(height: 2.h),
                InkWell(
                    child: Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: globalRed,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                      ),
                      child: Text(
                        "Okay thanks!",
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      FocusScope.of(context).unfocus();
                    }),
              ],
            ),
          ),
        ),
        titleWidget: Center(
          child: FaIcon(
            FontAwesomeIcons.cloudArrowUp,
            size: 8.h,
          ),
        ),
        callbackOK: () {},
        titleWidgetPadding: 10.w,
        titleWidgetSize: 20.w);
  }
}
