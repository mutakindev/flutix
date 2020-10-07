part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigning = false;

  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(children: [
                Container(
                  height: 56,
                  margin: EdgeInsets.only(top: 20, bottom: 90),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToSplashPage());
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            child: Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            "Confirm\nNew Account",
                            textAlign: TextAlign.center,
                            style: blackTextFont.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.registrationData.profilePicture == null)
                            ? AssetImage("assets/user_pic.png")
                            : FileImage(widget.registrationData.profilePicture),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text("Welcome",
                          style: blackTextFont.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      Text(widget.registrationData.name,
                          style: blackTextFont.copyWith(
                              fontSize: 20, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  height: 45,
                  margin: EdgeInsets.only(top: 110, bottom: 70),
                  child: (isSigning)
                      ? SpinKitFadingCircle(
                          color: mainColor,
                          size: 45,
                        )
                      : RaisedButton(
                          color: Color(0xFF3E9D9D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            "Create My Account",
                            style: whiteTextFont.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          onPressed: () async {
                            setState(() {
                              isSigning = true;
                            });

                            imageFileToUpload =
                                widget.registrationData.profilePicture;

                            SignInSignUpResult result =
                                await AuthServices.signUp(
                                    widget.registrationData.email,
                                    widget.registrationData.password,
                                    widget.registrationData.name,
                                    widget.registrationData.selectedGenres,
                                    widget.registrationData.selectedLanguage);

                            if (result.user == null) {
                              setState(() {
                                isSigning = false;
                              });

                              Flushbar(
                                duration: Duration(seconds: 4),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: result.message,
                              )..show(context);
                            }
                          }),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
