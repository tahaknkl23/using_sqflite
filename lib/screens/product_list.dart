import 'package:flutter/material.dart';
import 'package:sqlite_demo/data/dbHelper.dart';
import 'package:sqlite_demo/models/product.dart';
import 'package:sqlite_demo/screens/product_add.dart';
import 'package:sqlite_demo/screens/product_detail.dart';

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
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: buillProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        tooltip: "Add new product",
        child: const Icon(Icons.add),
      ),
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
            onTap: () {
              gotoDetail(products![position]);
            },
          ),
        );
      },
      itemCount: productCount,
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductAdd()),
    );
    if (result) {
      getProducts();
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      products = data;
      productCount = data.length;
    });
    if (products != null) {
      setState(() {});
    }
  }

  void gotoDetail(Product product) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetail(product)),
    );
    if (result) {
      getProducts();
    }
  }
}
