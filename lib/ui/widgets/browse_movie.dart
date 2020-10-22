part of 'widgets.dart';

class BrowseMovie extends StatelessWidget {
  final User user;
  final Function onTap;

  const BrowseMovie(this.user, {this.onTap});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List.generate(this.user.selectedGenres.length,
    (index)
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(7),
              margin: EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                color: Color(0x0FFEBEFF6),
                borderRadius:
                BorderRadius.all(Radius.circular(8)),
              ),
              child: Image.asset(
                "assets/ic_${this.user.selectedGenres[index].toLowerCase()}.png",
                width: 38,
                height: 38,
              )),
          Text("${this.user.selectedGenres[index]}",
              style: blackTextFont.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w400))
        ],
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
  }
}
