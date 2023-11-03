import 'package:auction_app/core/utils/app_constant.dart';
import 'package:auction_app/src/features/customer/view/profile/widgets/settting_item.dart';
import 'package:auction_app/src/theme/app_color.dart';
import 'package:auction_app/src/widgets/custom_image.dart';
import 'package:auction_app/src/widgets/custom_sliver_appbar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
        const Text(
          "User A",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "a@test.com",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImage(
          'https://avatars.githubusercontent.com/u/86506519?v=4',
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
