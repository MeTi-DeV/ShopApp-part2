import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'orders_screen.dart';
import '../widgets/cart_item.dart';
import '../providers/order.dart';
import '../providers/cart.dart' show Cart;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total :',
                    style: TextStyle(fontSize: 20),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        '${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  RaisedButton(
                    //comment 1 : here get all functions like addToOrder , CartClear , and route for go to ordersScreen
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(OrdersScreen.routeName);
                      orderData.addToOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.CartClear();
                    },
                    child: Text('Add To Order',
                        style: TextStyle(color: Colors.white)),
                    color: Colors.teal.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (BuildContext context, int index) => Container(
                child: CartItem(
                  cart.items.values.toList()[index].id,
                  //comment 2 : here pass each item key as productId to CartItem
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].title,
                  cart.items.values.toList()[index].price,
                  cart.items.values.toList()[index].quantity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
