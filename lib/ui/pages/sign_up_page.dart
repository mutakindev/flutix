part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;

  SignUpPage(this.registrationData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isConfirmPasswordValid = false;
  bool isSigningUp = false;

  @override
  void initState() {
    super.initState();

    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(top: 20, bottom: 22),
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
                              "Create New\nYour Account",
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
                    margin: EdgeInsets.only(bottom: 36),
                    width: 90,
                    height: 104,
                    child: Stack(children: [
                      Container(
                        child: (widget.registrationData.profilePicture == null)
                            ? Image.asset("assets/user_pic.png")
                            : FileImage(widget.registrationData.profilePicture),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            child: (widget.registrationData.profilePicture ==
                                    null)
                                ? Image.asset("assets/btn_add_photo.png")
                                : Image.asset("assets/btn_remove_photo.png"),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Full Name",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isEmailValid = EmailValidator.validate(text.trim());
                      });
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Email Address",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isPasswordValid = text.length >= 6;
                      });
                    },
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Password",
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isConfirmPasswordValid =
                            text == confirmPasswordController.text;
                      });
                    },
                    obscureText: true,
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Confirm Password",
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(top: 30, bottom: 50),
                    child: isSigningUp
                        ? SpinKitFadingCircle(
                            color: mainColor,
                          )
                        : FloatingActionButton(
                            elevation: 0,
                            backgroundColor: (isEmailValid &&
                                    isPasswordValid &&
                                    isConfirmPasswordValid)
                                ? mainColor
                                : accentColor3,
                            child: Icon(Icons.arrow_forward,
                                color: (isEmailValid &&
                                        isPasswordValid &
                                            isConfirmPasswordValid)
                                    ? Colors.white
                                    : Colors.grey),
                            onPressed: () {
                              context.bloc<PageBloc>().add(
                                  GoToPreferencePage(widget.registrationData));
                            },
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
