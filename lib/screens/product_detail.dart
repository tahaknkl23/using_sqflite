// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:sqlite_demo/data/dbHelper.dart';
import 'package:sqlite_demo/models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

enum Options { delete, update }

class _ProductDetailState extends State<ProductDetail> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unPrice.toString();

    super.initState();
  }

  Product get product => widget.product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details  : ${product.name}"),
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (context) {
              return <PopupMenuEntry<Options>>[
                const PopupMenuItem<Options>(
                  value: Options.delete,
                  child: Text("Delete"),
                ),
                const PopupMenuItem<Options>(
                  value: Options.update,
                  child: Text("Update"),
                ),
              ];
            },
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildUnitPriceField(),
          buildSaveButton(),
        ],
      ),
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

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.update(
          Product.withId(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unPrice: double.tryParse(txtUnitPrice.text)!,
          ),
        );
        Navigator.pop(context, true);
        break;

      default:
    }
  }

  void addProduct() async {
    await dbHelper.insert(
      Product(
        name: txtName.text,
        description: txtDescription.text,
        unPrice: double.tryParse(txtUnitPrice.text)!,
        id: 0,
      ),
    );

    Navigator.pop(context, true);
  }
}
