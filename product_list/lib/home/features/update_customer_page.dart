import 'package:flutter/material.dart';
import 'package:product_list/utils/app_text.dart';

class UpdateCustomerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppText.appbarUpdateCustomer),
      ),
      body: const Center(
        child: Text(AppText.appbarAddNewCustomer),
      ),
    );
  }
}

class Hello extends StatefulWidget {
  const Hello({super.key});

  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

