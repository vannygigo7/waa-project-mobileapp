import 'package:auction_app/src/features/customer/view/home/home_page.dart';
import 'package:auction_app/src/features/customer/view/my_bid/my_bid_page.dart';
import 'package:auction_app/src/features/customer/view/profile/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/bottombar_item.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int _activeTab = 0;
  final List<_BarItem> _barItems = [
    _BarItem(
        icon: "assets/icons/home.svg",
        activeIcon: "assets/icons/home.svg",
        page: const HomePage()),
    _BarItem(
        icon: "assets/icons/search.svg",
        activeIcon: "assets/icons/search.svg",
        page: const SizedBox()),
    _BarItem(
        icon: "assets/icons/time.svg",
        activeIcon: "assets/icons/time.svg",
        page: const MyBidPage()),
    _BarItem(
        icon: "assets/icons/profile.svg",
        activeIcon: "assets/icons/profile.svg",
        page: ProfilePage()),
  ];

//====== set animation=====
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: AppConstant.animateBodyDurationMS),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

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

  _buildAnimatedPage(page) {
    return FadeTransition(child: page, opacity: _animation);
  }

  void onPageChanged(int index) {
    if (index == _activeTab) return;
    _controller.reset();
    setState(() {
      _activeTab = index;
    });
    _controller.forward();
  }

//====== end set animation=====

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      bottomNavigationBar: _buildBottomBar(),
      body: _buildPage(),
    );
  }

  Widget _buildPage() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        _barItems.length,
        (index) => _buildAnimatedPage(_barItems[index].page),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.bottomBarColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadowColor.withOpacity(0.1),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: _buildBottomIcon(),
    );
  }

  Widget _buildBottomIcon() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          _barItems.length,
          (index) => BottomBarItem(
            _barItems[index].icon,
            isActive: _activeTab == index,
            activeColor: AppColor.primary,
            onTap: () {
              onPageChanged(index);
            },
          ),
        ),
      ),
    );
  }
}

class _BarItem {
  String icon;
  String activeIcon;
  Widget page;
  _BarItem({
    required this.icon,
    required this.activeIcon,
    required this.page,
  });
}
