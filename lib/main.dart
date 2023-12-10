import 'package:auction_app/core/services/injection_container.dart';
import 'package:auction_app/src/features/auth/view/login/login_page.dart';
import 'package:auction_app/src/features/customer/cubit/add_bid/add_bit_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/auction/auction_cubit.dart';
import 'package:auction_app/src/features/customer/cubit/my_bid/my_bid_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator.get<AuctionCubit>()),
        BlocProvider(create: (_) => locator.get<MyBidCubit>()),
        BlocProvider(create: (_) => locator.get<AddBidCubit>()),
      ],
      child: MaterialApp(
        title: 'Auction App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
