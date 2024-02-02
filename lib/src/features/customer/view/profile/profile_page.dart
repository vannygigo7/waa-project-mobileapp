import 'package:auction_app/core/services/auth_manager.dart';
import 'package:auction_app/core/styles/app_color.dart';
import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/core/utils/app_util.dart';
import 'package:auction_app/core/utils/dummy_data.dart';
import 'package:auction_app/src/features/auth/cubit/auth_cubit.dart';
import 'package:auction_app/src/features/customer/model/user_model.dart';
import 'package:auction_app/src/features/customer/view/profile/widgets/settting_item.dart';
import 'package:auction_app/src/widgets/custom_image.dart';
import 'package:auction_app/src/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_avatar/random_avatar.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  UserModel user = UserModel.fromJson(userData);

  ProfilePage({super.key});

  loadUser() async {
    user = await AuthManager.instance.user ?? user;
  }

  @override
  Widget build(BuildContext context) {
    loadUser();
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: AppColor.appBarColor,
            pinned: true,
            snap: true,
            floating: true,
            title: CustomSliverAppbar(
              title: "Profile",
            ),
          ),
          SliverToBoxAdapter(
            child: _buildBody(context),
          )
        ],
      ),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfile(),
          _buildSettingList(context),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _buildProfileImage(),
        const SizedBox(
          height: 10,
        ),
        Text(
          "${user.firstName} ${user.lastName}",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          user.email,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppUtil.checkIsNull(user.profileImageUrl)
            ? RandomAvatar(user.email,
                trBackground: true, width: 70, height: 70)
            : CustomImage(
                user.profileImageUrl!,
                imageType: ImageType.network,
                width: 70,
                height: 70,
                radius: 100,
              )
      ],
    );
  }

  Widget _buildSettingList(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 20, bottom: 10),
      child: Column(
        children: [
          SettingItem(
            title: "Edit Profile",
            leadingIcon: Icons.person,
            leadingIconColor: AppColor.green,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Favorites",
            leadingIcon: Icons.favorite,
            leadingIconColor: AppColor.primary,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Change Theme",
            leadingIcon: Icons.dark_mode_rounded,
            leadingIconColor: AppColor.orange,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Feedback",
            leadingIcon: Icons.rate_review,
            leadingIconColor: AppColor.blue,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          const SettingItem(
            title: "Version",
            leadingIcon: Icons.system_update,
            leadingIconColor: AppColor.labelColor,
            trailing: Text(
              AppConstant.appVersion,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SettingItem(
            title: "Logout",
            leadingIcon: Icons.logout,
            leadingIconColor: AppColor.red,
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ),
            onTap: () {
              BlocProvider.of<AuthCubit>(context).logOut();
            },
          ),
        ],
      ),
    );
  }
}
