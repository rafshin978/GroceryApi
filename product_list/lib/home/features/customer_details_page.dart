import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_list/customer/controller/user_controller.dart';
import 'package:product_list/customer/user_model.dart';
import 'package:product_list/home/features/customer_detail_id.dart';
import 'package:product_list/utils/app_text.dart';

class CustomerDetailsScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.appbarCustomerDetails),
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (userController.userList.isEmpty) {
          return const Center(
            child: Text(AppText.noCustomerError),
          );
        } else {
          return ListView.builder(
            itemCount: userController.userList.length,
            itemBuilder: (context, index) {
              final user = userController.userList[index];
              return Card(
                child: ListTile(
                  title: Text(user.name ?? AppText.noNameError),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Mobile: ${user.mobileNumber ??
                              AppText.noMobileNumberError}'),
                      Text('Email: ${user.email ?? AppText.noEmailError}'),
                      Text('City: ${user.city ?? AppText.noCityError}'),
                    ],
                  ),

                  onTap: () async {
                    await userController.fetchUserById(user.id!);
                    Get.to(() => CustomerDetailIdScreen(),arguments: user.id);
                  },
                  // {
                  //   final userDetail = userController.userDetail();
                  //   _navigateToUserDetailId(userDetail.id);
                  // },

                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userController.fetchUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  // void _navigateToUserDetailId(int? userId) {
  //   if (userId != null) {
  //     Get.to(() => CustomerDetailIdScreen(userId: userId));
  //   } else {
  //     print('User ID is null');c
  //     // Handle the case when user.id is null
  //     Get.snackbar('Error', 'User ID is null');
  //   }
  // }

  // void _navigateToUserDetailId(int userId) async {
  //   await userController.fetchUserById(userId);
  //   Get.to(() => CustomerDetailIdScreen(userId: userId));
  // }
}