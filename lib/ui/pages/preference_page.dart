part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSignUpPage(widget.registrationData));
        return;
      },
      child: Scaffold(),
    );
  }
}
