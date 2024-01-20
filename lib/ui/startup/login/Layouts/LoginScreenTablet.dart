import 'package:flutter/services.dart';
import 'package:ovh.fso.dtubego/res/Config/appConfigValues.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:ovh.fso.dtubego/bloc/avalonConfig/avalonConfig_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/thirdPartyLogin/thirdPartyLogin_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';

import 'package:ovh.fso.dtubego/ui/startup/OnboardingJourney/OnboardingJourney.dart';
import 'package:ovh.fso.dtubego/ui/startup/login/widgets/LoginWithCredentials.dart';
import 'package:ovh.fso.dtubego/ui/startup/login/pages/SocialUserActionPopup.dart';
import 'package:ovh.fso.dtubego/ui/startup/login/services/ressources.dart';
import 'package:ovh.fso.dtubego/ui/startup/login/widgets/sign_in_button.dart';

import 'package:ovh.fso.dtubego/bloc/auth/auth_bloc_full.dart';
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginFormTablet extends StatefulWidget {
  final String? message;
  final String? username;
  final bool showOnboardingJourney;

  bool googleFree = (appFlavor != null && appFlavor == "GoogleFree");

  LoginFormTablet({
    Key? key,
    this.message,
    this.username,
    required this.showOnboardingJourney,
  }) : super(key: key);

  @override
  _LoginFormTabletState createState() => _LoginFormTabletState();
}

class _LoginFormTabletState extends State<LoginFormTablet> {
  late bool _journeyDone;
  late AuthBloc _loginBloc;
  bool _loginWithCredentialsVisible = false;

  bool _authIsLoading = false;
  String _uid = "";
  late String _currentHF = "0";

  void getCurrentHF() async {
    String _hardfork = await sec.getLocalConfigString(sec.settingKey_currentHF);
    setState(() {
      // override this to simulate another hardfork
      _currentHF = _hardfork;
      // _currentHF = "6"; // example: setting current active hardfork to hf6
    });
  }

  @override
  void initState() {
    _journeyDone = !widget.showOnboardingJourney;

    _loginBloc = BlocProvider.of<AuthBloc>(context);
    getCurrentHF();
    super.initState();
  }

  void journeyDoneCallback() async {
    // await sec.persistOnbordingJourneyDone();
    setState(() {
      _journeyDone = true;
    });
    BlocProvider.of<AuthBloc>(context).add(StartBrowseOnlyMode());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalBlue,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Container(
                height: 900,
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Image.asset('assets/images/dtube_logo_white.png',
                          width: 300),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _loginWithCredentialsVisible =
                                    !_loginWithCredentialsVisible;
                              });
                            },
                            child: Container(
                              width: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _loginWithCredentialsVisible
                                      ? Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: FaIcon(
                                            FontAwesomeIcons.arrowLeft,
                                            size: 30,
                                          ),
                                        )
                                      : Image.asset(
                                          'assets/images/dtube_logo_white.png',
                                          width: 30),
                                  Text(!_loginWithCredentialsVisible
                                      ? "Signin with private key"
                                      : "back")
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Social Providers
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Visibility(
                            visible: !_loginWithCredentialsVisible,
                            child: Container(
                              width: 350,
                              child: Column(
                                children: [
                                  (int.parse(_currentHF) >= 6 &&
                                          widget.googleFree == false)
                                      ? Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 5,
                                          runSpacing: 5,
                                          children: [
                                            SignInButton(
                                              width: 100,
                                              faIcon: FaIcon(
                                                  FontAwesomeIcons.google),
                                              loginType: LoginType.Google,
                                              activated: true,
                                              loggedInCallback:
                                                  loggedInCallback,
                                            ),
                                            SignInButton(
                                              width: 100,
                                              faIcon: FaIcon(
                                                  FontAwesomeIcons.facebook),
                                              loginType: LoginType.Facebook,
                                              activated: true,
                                              loggedInCallback:
                                                  loggedInCallback,
                                            ),
                                            /*
                                            SignInButton(
                                              width: 100,
                                              faIcon: FaIcon(
                                                  FontAwesomeIcons.github),
                                              loginType: LoginType.Github,
                                              activated: true,
                                              loggedInCallback:
                                                  loggedInCallback,
                                            ),*/
                                            SignInButton(
                                              width: 100,
                                              faIcon: FaIcon(
                                                  FontAwesomeIcons.twitter),
                                              loginType: LoginType.Twitter,
                                              activated: true,
                                              loggedInCallback:
                                                  loggedInCallback,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: InputChip(
                                        backgroundColor: Colors.green.shade700,
                                        onPressed: () {
                                          _loginBloc.add(StartBrowseOnlyMode());
                                        },
                                        label: Text(
                                          "continue without login",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Visibility(
                            visible: _loginWithCredentialsVisible,
                            child: LoginWithCredentials(
                              username: widget.username,
                              message: widget.message,
                              width: 300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            width: 400,
                            child: Text(
                                "DTube is a video sharing platform operating on the Avalon blockchain with a world wide community and possibilities to cross-post to various other social block chains like hive and blurt!",
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InputChip(
                                  backgroundColor: globalAlmostWhite,
                                  onPressed: () {
                                    launchUrl(Uri.parse(AppConfig.readmoreUrl));
                                  },
                                  label: Text(
                                    "read the whitepaper",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: globalBlue),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: InputChip(
                                    backgroundColor: globalAlmostWhite,
                                    onPressed: () {
                                      launchUrl(
                                          Uri.parse(AppConfig.discordUrl));
                                    },
                                    label: Container(
                                      width: 210,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Join the DTube Discord",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(color: globalBlue),
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.discord,
                                            color: globalBGColor,
                                          )
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // onboarding Journey
          Visibility(
            child: OnboardingJourney(
              journeyDoneCallback: journeyDoneCallback,
            ),
            visible: !_journeyDone,
          ),
        ],
      ),
    );
  }

  void loggedInCallback(String socialUId, String socialProvider) async {
    setState(() {
      _uid = socialUId;
    });
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => MultiBlocProvider(
                providers: [
                  BlocProvider<ThirdPartyLoginBloc>(
                      create: (context) => ThirdPartyLoginBloc(
                          repository: ThirdPartyLoginRepositoryImpl())
                        ..add(TryThirdPartyLoginEvent(
                            socialUId: socialUId,
                            socialProvider: socialProvider))),
                  BlocProvider<AvalonConfigBloc>(
                      create: (context) => AvalonConfigBloc(
                          repository: AvalonConfigRepositoryImpl())),
                  BlocProvider<TransactionBloc>(
                      create: (context) => TransactionBloc(
                          repository: TransactionRepositoryImpl())),
                ],
                child: SocialUserActionPopup(
                  socialUId: socialUId,
                )));
  }
}
