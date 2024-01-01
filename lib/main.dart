import 'package:auction_app/core/services/injection_container.dart';
import 'package:auction_app/src/features/auth/cubit/auth_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/auth_state.dart';
import 'package:auction_app/src/features/auth/cubit/login_cubit.dart';
import 'package:auction_app/src/features/auth/cubit/register_cubit.dart';
import 'package:auction_app/src/features/auth/view/login/login_page.dart';
import 'package:auction_app/src/features/customer/cubit/add_bid/add_bit_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_cubit.dart';
import 'package:auction_app/src/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator.get<AuctionCubit>()),
        BlocProvider(create: (_) => locator.get<MyBidCubit>()),
        BlocProvider(create: (_) => locator.get<AddBidCubit>()),
        BlocProvider(create: (_) => locator.get<AuthCubit>()),
        BlocProvider(create: (_) => locator.get<LoginCubit>()),
        BlocProvider(create: (_) => locator.get<RegisterCubit>()),
      ],
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Auction App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (context, child) {
          BlocProvider.of<AuthCubit>(context).checkAuthState();
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthStatus.authenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    RootApp.route(),
                    (route) => false,
                  );
                case AuthStatus.unAuthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                default:
                  break;
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (settings) => LoginPage.route(),
      ),
    );
  }
}
