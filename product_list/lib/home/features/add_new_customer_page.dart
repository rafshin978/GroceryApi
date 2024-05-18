import 'package:flutter/material.dart';
import 'package:product_list/utils/app_text.dart';

class AddNewCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.appbarAddNewCustomer),
      ),
      body: const Center(
        child: Text(AppText.appbarAddNewCustomer),
      ),
    );
  }
}
