import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/src/features/customer/view/home/home_page.dart';
import 'package:auction_app/src/features/customer/view/my_bid/my_bid_page.dart';
import 'package:auction_app/src/features/customer/view/profile/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/src/widgets/bottombar_item.dart';

class RootApp extends StatefulWidget {
  const RootApp({Key? key}) : super(key: key);
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const RootApp());
  }

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> with TickerProviderStateMixin {
  int _activeTab = 0;
  late final List<_BarItem> _barItems;

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
    _barItems = [
      _BarItem(
          icon: "assets/icons/home.svg",
          activeIcon: "assets/icons/home.svg",
          page: const HomePage()),
      _BarItem(
          icon: "assets/icons/time.svg",
          activeIcon: "assets/icons/time.svg",
          page: const MyBidPage()),
      _BarItem(
          icon: "assets/icons/bell.svg",
          activeIcon: "assets/icons/bell.svg",
          page: const Center(
            child: Text("Notification"),
          )),
      _BarItem(
          icon: "assets/icons/profile.svg",
          activeIcon: "assets/icons/profile.svg",
          page: ProfilePage()),
    ];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
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

  void _onPageChanged(int index) {
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
      bottomNavigationBar: _BottomBar(
        barItems: _barItems,
        onTap: (index) => _onPageChanged(index),
        activeIndex: _activeTab,
      ),
      body: _buildPages(),
    );
  }

  Widget _buildPages() {
    return IndexedStack(
      index: _activeTab,
      children: List.generate(
        _barItems.length,
        (index) => _buildAnimatedPage(_barItems[index].page),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar(
      {required this.barItems, required this.onTap, this.activeIndex = 0});

  final List<_BarItem> barItems;
  final int activeIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
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
          barItems.length,
          (index) => BottomBarItem(
            barItems[index].icon,
            isActive: activeIndex == index,
            activeColor: AppColor.primary,
            onTap: () => onTap(index),
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
