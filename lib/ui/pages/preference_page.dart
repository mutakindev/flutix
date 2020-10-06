part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];
  final List<String> languages = [
    "English",
    "Indonesia",
    "Japanese",
    "Korean",
  ];

  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context.bloc<PageBloc>().add(GoToSignUpPage(widget.registrationData));
          return;
        },
        child: Scaffold(
          body: Center(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        margin: EdgeInsets.only(top: 20, bottom: 4),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .bloc<PageBloc>()
                                .add(GoToSignUpPage(widget.registrationData));
                          },
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Text(
                        "Select Your Four\nFavorite Genres",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: generateGenresWidget(context),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Select Language",
                        style: blackTextFont.copyWith(fontSize: 20),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: generateLanguagesWidget(context),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: FloatingActionButton(
                          backgroundColor: mainColor,
                          elevation: 0,
                          onPressed: () {
                            if (selectedGenres.length != 4) {
                              Flushbar(
                                duration: Duration(seconds: 2),
                                backgroundColor: accentColor2,
                                message: "Please select 4 genre",
                                flushbarPosition: FlushbarPosition.TOP,
                              )..show(context);
                            } else {
                              widget.registrationData.selectedGenres =
                                  selectedGenres;
                              widget.registrationData.selectedLanguage =
                                  selectedLanguage;

                              context.bloc<PageBloc>().add(
                                  GoToAccountConfirmationPage(
                                      widget.registrationData));
                            }
                          },
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                      SizedBox(height: 50)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<Widget> generateGenresWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: (selectedGenres.contains(e)),
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
      print(selectedGenres);
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
        print(selectedGenres);
      }
    }
  }

  List<Widget> generateLanguagesWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: (selectedLanguage == e),
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }
}
