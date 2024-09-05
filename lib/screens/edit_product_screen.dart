import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/widgets/app_drawer.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.save,
                color: Colors.purple,
                size: 30,
              ))
        ],
      ),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
              textInputAction: TextInputAction.next,
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Price'),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('Description'),
              ),
              textInputAction: TextInputAction.next,
            ),
          ],
        ),
      ),
    );
  }
}
