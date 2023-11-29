import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/widgets/DialogTemplates/DialogWithTitleLogo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UploadStartedDialog extends StatelessWidget {
  const UploadStartedDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopUpDialogWithTitleLogo(
        showTitleWidget: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 7.h),
                child: Text("Amazing!",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 2.h),
              Text(
                  "Your new video is uploading right now and this could take some time...",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
              Text(
                  "It is safe to browse DTube Go in the meantime. Go share some feedback and votes on other videos of the community.",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
              SizedBox(height: 3.h),
              Text(
                  "Make sure to not close the app or lock your screen until the upload is finished!",
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
                      "Allright!",
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
        titleWidget: Center(
          child: FaIcon(
            FontAwesomeIcons.cloudArrowUp,
            size: 8.h,
          ),
        ),
        callbackOK: () {},
        titleWidgetPadding: 20.w,
        titleWidgetSize: 10.w);
  }
}
