import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';

import '../controllers/bookshome_controller.dart';

class BookshomeView extends GetView<BookshomeController> {
  const BookshomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('BookshomeView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'BookshomeView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
