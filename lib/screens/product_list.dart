import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqlite_demo/data/dbHelper.dart';
import 'package:sqlite_demo/models/product.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  void initState() {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      products = data;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: buillProductList(),
    );
  }

  ListView buillProductList() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.cyan,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text('P'),
            ),
            title: Text(products![position].name),
            subtitle: Text(products![position].description),
            onTap: () {},
          ),
        );
      },
      itemCount: productCount,
    );
  }
}
