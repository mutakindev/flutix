part of 'pages.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 134,
          decoration: BoxDecoration(
            color: Color(0x0FF2C1F63),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 30),
          // ignore: missing_return
          child: BlocBuilder<UserBloc, UserState>(builder: (_, userState) {
            if (userState is UserLoaded) {
              Row(
                children: [
                  Text("Name"),
                  Text(""),
                ],
              );
            } else {
              SpinKitFadingCircle(
                color: accentColor2,
                size: 50,
              );
            }
          }),
        )
      ],
    );
  }
}
