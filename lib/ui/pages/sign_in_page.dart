part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor2)));
    return WillPopScope(
      onWillPop: () {
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 70,
                    child: Image.asset("assets/logo.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 40),
                    child: Text("Welcome Back.\nExplorer",
                        style: blackTextFont.copyWith(fontSize: 20)),
                  ),
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
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "Forgot password? ",
                        style: greyTextFont.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      Text("Get Now ",
                          style: purpleTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 30, bottom: 50),
                      child: isSigningIn
                          ? SpinKitFadingCircle(
                              color: mainColor,
                            )
                          : FloatingActionButton(
                              elevation: 0,
                              backgroundColor: (isEmailValid && isPasswordValid)
                                  ? mainColor
                                  : accentColor3,
                              child: Icon(Icons.arrow_forward,
                                  color: (isEmailValid && isPasswordValid)
                                      ? Colors.white
                                      : Colors.grey),
                              onPressed: () async {
                                if (isEmailValid && isPasswordValid) {
                                  setState(() {
                                    isSigningIn = true;
                                  });
                                  SignInSignUpResult result =
                                      await AuthServices.signIn(
                                          emailController.text.trim(),
                                          passwordController.text.trim());
                                  print(result.user);

                                  if (result.user == null) {
                                    setState(() {
                                      isSigningIn = false;
                                    });
                                    Flushbar(
                                      duration: Duration(seconds: 4),
                                      flushbarPosition: FlushbarPosition.TOP,
                                      backgroundColor: Color(0xFFFF5C83),
                                      message: result.message,
                                    )..show(context);
                                  } else {}
                                } else {
                                  return null;
                                }
                              }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Start fresh now? ",
                        style: greyTextFont.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.bloc<PageBloc>().add(GoToSignUpPage());
                        },
                        child: Text("Sign Up ",
                            style: purpleTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    ],
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
