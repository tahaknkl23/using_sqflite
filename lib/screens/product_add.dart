import 'package:flutter/material.dart';
import 'package:sqlite_demo/data/dbHelper.dart';
import 'package:sqlite_demo/models/product.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();
  var dbHelper = DbHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              buildNameField(),
              buildDescriptionField(),
              buildUnitPriceField(),
              buildSaveButton(),
            ],
          )),
    );
  }

  buildNameField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Product Name'),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Product Description'),
      controller: txtDescription,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: const InputDecoration(labelText: 'Product Unit Price'),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return ElevatedButton(
        onPressed: () {
          addProduct();
        },
        child: const Text("Save Product"));
  }

  void addProduct() async {
    var resutl = await dbHelper.insert(Product(
      name: txtName.text,
      description: txtDescription.text,
      unPrice: double.tryParse(txtUnitPrice.text)!,
    ));

    Navigator.pop(context, true);
  }
}
