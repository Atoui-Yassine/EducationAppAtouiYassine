import 'package:flutter/material.dart';
import 'package:oedu/screens/account.dart';
import 'package:oedu/screens/chat.dart';
import 'package:oedu/screens/home.dart';
import 'package:oedu/theme/color.dart';
import 'package:oedu/utils/constant.dart';
import 'package:oedu/widgets/bottombar_item.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  // lor en utlis plus de un animation
  int _activeTab = 0;
  List _barItems = [
    {
      "icon": "assets/icons/home.svg",
      "active_icon": "assets/icons/home.svg",
      "page": HomePage(),
    },
    {
      "icon": "assets/icons/search.svg",
      "active_icon": "assets/icons/search.svg",
      "page": Container(),
    },
    {
      "icon": "assets/icons/play.svg",
      "active_icon": "assets/icons/play.svg",
      "page": Container(),
    },
    {
      "icon": "assets/icons/chat.svg",
      "active_icon": "assets/icons/chat.svg",
      "page": ChatPage(),
    },
    {
      "icon": "assets/icons/profile.svg",
      "active_icon": "assets/icons/profile.svg",
      "page": AccountPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      bottomNavigationBar: _buildBottomBar(),
      body: _buildPage(),
    );
  }
///////start animation /////////

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: ANIMATED_BODY_MS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
      //Elle sera initialisée plus tard dans le code.
      parent: _controller,
      curve: Curves
          .fastLinearToSlowEaseIn); // commence linéairement puis ralentit progressivement vers la fin.

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  _buildAnimationPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    _controller.reset();
    setState(() {
      _activeTab = index;
    });
    _controller.forward();
  }

//////end animation   /////////
  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(_barItems.length,
          (index) => _buildAnimationPage(_barItems[index]["page"])),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.bottomBarColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: Offset(1, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              _barItems.length,
              (index) => BottomBarItem(_barItems[index]["icon"],
                      isActive: _activeTab == index,
                      activeColor: AppColor.primary, onTap: () {
                    onPageChanged(index);
                  })),
        ),
      ),
    );
  }
}
