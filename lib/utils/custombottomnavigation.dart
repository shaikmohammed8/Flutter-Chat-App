import 'package:chat_app/controller/firestore.dart';
import 'package:chat_app/screens/chathome/chathome.dart';
import 'package:chat_app/screens/friendsScreen/firendsscreen.dart';
import 'package:chat_app/screens/settingScreen/settingscreen.dart';
import 'package:chat_app/services/firestroresevice.dart';
import 'package:chat_app/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with WidgetsBindingObserver {
  var controller = Get.lazyPut<FireStoreController>(() {
    Get.smartManagement = SmartManagement.keepFactory;
    return FireStoreController();
  });
  var index = 0;
  var firestore = FireStoreDB();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    var cUid = FirebaseAuth.instance.currentUser.uid;
    switch (state) {
      case AppLifecycleState.detached:
        cUid != null
            ? firestore.updateState(cUid, UserState.OFFLINE)
            : print("offline");
        break;
      case AppLifecycleState.paused:
        cUid != null
            ? firestore.updateState(cUid, UserState.AWAY)
            : print("away");
        break;
      case AppLifecycleState.resumed:
        cUid != null
            ? firestore.updateState(cUid, UserState.ONLINE)
            : print("online");
        break;
      case AppLifecycleState.inactive:
        cUid != null
            ? firestore.updateState(cUid, UserState.OFFLINE)
            : print("Offline");
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  void onTap(int index) {
    setState(() {
      this.index = index;
    });
  }

  List<Widget> screens = [ChatHomeScreen(), FirendsScreen(), SettingScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: this.index,
            children: screens,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.chat_bubble_rounded,
                          color: Colors.grey[400],
                        ),
                        label: "",
                        activeIcon: Column(
                          children: [
                            Icon(Icons.chat_bubble_rounded, size: 24),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 5,
                              width: 5,
                              child: CircleAvatar(
                                backgroundColor: Get.theme.primaryColor,
                              ),
                            ),
                          ],
                        )),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.people_alt_sharp,
                        color: Colors.grey[400],
                      ),
                      label: "",
                      activeIcon: Column(
                        children: [
                          Icon(Icons.people_alt_sharp, size: 24),
                          SizedBox(
                            height: 2,
                          ),
                          Container(
                            height: 5,
                            width: 5,
                            child: CircleAvatar(
                              backgroundColor: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.grey[400],
                        ),
                        label: "",
                        activeIcon: Column(
                          children: [
                            Icon(Icons.settings),
                            SizedBox(
                              height: 2,
                            ),
                            Container(
                              height: 5,
                              width: 5,
                              child: CircleAvatar(
                                backgroundColor: Get.theme.primaryColor,
                              ),
                            ),
                          ],
                        )),
                  ],
                  onTap: onTap,
                  currentIndex: index,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
