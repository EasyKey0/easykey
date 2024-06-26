import 'package:easykey/custom/custom_color.dart';
import 'package:easykey/screens/ads_add_page.dart';
import 'package:easykey/screens/advertisement_page.dart';
import 'package:easykey/screens/chatlist_page.dart';
import 'package:easykey/screens/favorites_page.dart';
import 'package:easykey/screens/myads_page.dart';
import 'package:easykey/screens/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.userData});

  final userData;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ScrollController scrollController;
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      print(scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            backgroundColor: CustomColors.primaryColor,
            foregroundColor: CustomColors.secondaryColor,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addAdd(userData: widget.userData),
                  ));
            },
            child: Icon(Icons.add_rounded)),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            ChatList(userData: widget.userData))));
              },
            )
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32))),
          automaticallyImplyLeading: false,
          title: Text("EasyKey"),
          backgroundColor: CustomColors.primaryColor,
        ),
        body: TabBarView(children: [
          advertPage(userData: widget.userData),
          FavoritesPage(userData: widget.userData),
          myAdsPage(userData: widget.userData),
          profilePage(userData: widget.userData)
        ]),
        bottomNavigationBar: BottomAppBar(
          elevation: 99,
          color: CustomColors.primaryColor,
          clipBehavior: Clip.antiAlias,
          notchMargin: 5,
          shape: CircularNotchedRectangle(),
          child: TabBar(
              dividerHeight: 0,
              unselectedLabelColor: Colors.white,
              labelColor: CustomColors.secondaryColor,
              indicator: BoxDecoration(),
              tabs: [
                Tab(
                  text: "İlanlar",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "Favoriler",
                  icon: Icon(Icons.favorite),
                ),
                Tab(
                  text: "İlanlarım",
                  icon: Icon(Icons.list),
                ),
                Tab(
                  text: "Hesabım",
                  icon: Icon(Icons.account_circle),
                )
              ]),
        ),
      ),
    );
  }
}
