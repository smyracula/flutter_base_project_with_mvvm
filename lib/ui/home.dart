import 'package:flutter/material.dart';

int selectedPosition = 0;
PageController pageController;

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  final List<Widget> _appBars = <Widget>[
    Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Text(
          "Smyracula Base Flutter Project",
          style: TextStyle(
              fontFamily: 'Sailec',
              fontSize: 15,
              color: UIHelper.WHITE,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400),
        )),
    Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Text(
          UIHelper.timers,
          style: TextStyle(
              fontFamily: 'Sailec',
              fontSize: 20,
              color: UIHelper.WHITE,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        )),
    Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Text(
          UIHelper.more,
          style: TextStyle(
              fontFamily: 'Sailec',
              fontSize: 20,
              color: UIHelper.WHITE,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700),
        )),
  ];

  Widget appBarSelectedWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
    pageController.addListener(_handleSelected);
    appBarSelectedWidget = _appBars[0];
  }

  void _handleSelected() {
    setState(() {
      appBarSelectedWidget = _appBars[pageController.page.toInt()];
    });
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: UIHelper.WHITE),
          backgroundColor: UIHelper.BLACK,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: appBarSelectedWidget),
                  )),
              Expanded(
                  flex: 1,
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Image.asset(
                          UIHelper.user,
                          height: 36,
                        ),
                      )))
            ],
          )),
      backgroundColor: UIHelper.DARK_GREY,
      body: bodyContainer(),
      bottomNavigationBar: ReviveBottomNavigationBar(),
    );
  }

  Widget bodyContainer() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: <Widget>[
        UpdatesScreen(),
        WorkoutsScreen(),
        TimersScreen(),
        MoreScreen()
      ],
    );
  }
}
