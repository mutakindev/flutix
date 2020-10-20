part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int bottomNavBarIndex;
  PageController pageController;

  @override
  void initState() {
    super.initState();

    bottomNavBarIndex = 0;
    pageController = PageController(initialPage: bottomNavBarIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(color: accentColor1),
        SafeArea(
            child: Container(
          color: Color(0x0FFF6F7F9),
        )),
        PageView(
          controller: pageController,
          onPageChanged: (index){
            setState(() {
              bottomNavBarIndex = index;
            });
          },
          children: [
            MoviePage(),
            Center(child:Text("Tickets Page")),
          ],
        ),
        createBottomNavBar(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 46,
            height: 46,
            margin: EdgeInsets.only(bottom: 42),
            child: FloatingActionButton(
              backgroundColor: accentColor2,
              elevation: 0,
              onPressed: (){
                AuthServices.signOut();
              },
              child: SizedBox(
                  width: 26,
                  height: 26,
                  child: Icon(
                    MdiIcons.walletPlus,
                    color: Colors.black.withOpacity(0.54),
                  )),
            ),
          ),
        )
      ],
    ));
  }

  Widget createBottomNavBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: BottomNavBarClicpper(),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey,
            currentIndex: bottomNavBarIndex,
            onTap: (index) {
              setState(() {
                bottomNavBarIndex = index;
                pageController.jumpToPage(index);
              });
            },
            items: [
              BottomNavigationBarItem(
                label: 'New Movies',
                icon: Container(
                    margin: EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset((bottomNavBarIndex == 0)
                        ? "assets/ic_movies.png"
                        : "assets/ic_movies_gray.png")),
              ),
              BottomNavigationBarItem(
                label: 'My Tickets',
                icon: Container(
                    margin: EdgeInsets.only(bottom: 6),
                    height: 20,
                    child: Image.asset((bottomNavBarIndex == 1)
                        ? "assets/ic_tickets.png"
                        : "assets/ic_tickets_gray.png")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavBarClicpper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
