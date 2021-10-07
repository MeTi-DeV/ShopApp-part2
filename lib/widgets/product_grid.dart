import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  //comment 1 : define a bool variable for resive products ar favorite or not
  final bool isFave;
  ProductGrid(this.isFave);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    //comment 2 : and here compare  isFave with our FavoriteList that created in Products
    // if it was true we can see only favorites Otherwise we can't
    final products = isFave ? productsData.FavoriteList : productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) => 
      //comment 3 : use ChangeNotifierProvider.value for GridView and ListView and widgets like these
      ChangeNotifierProvider.value(
        value: products[index],
        child: Container(
          padding: EdgeInsets.all(5),
          child: ProductItem(),
        ),
      ),
    );
  }
}
