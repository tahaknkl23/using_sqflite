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
  DbHelper dbHelper = DbHelper();
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

  buildProductDetail() {}

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id);
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
