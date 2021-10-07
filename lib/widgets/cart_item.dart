import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  //comment 1 : add new variable productId for us e ass key for delete each items we want to remove it in cart screen
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItem(this.id, this.productId, this.title, this.price, this.quantity);
  @override
  Widget build(BuildContext context) {
    //comment 2 : Dismissible is a widget that for swiping to left or right to  delete that cart or share it some things like these
    return Dismissible(
      //comment 3 : a important properties of Dismissible is key for get a key of each item
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: ListTile(
          leading: Container(
              child: Text(
            '${quantity} x',
            textAlign: TextAlign.center,
          )),
          title: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${(price * quantity).toStringAsFixed(2)}'),
          trailing: Container(
            decoration: BoxDecoration(
                color: Colors.pink.shade500,
                borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.all(10),
            child: Text(
              '${price.toStringAsFixed(2)}\$',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      
      onDismissed: (directin) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
    );
  }
}
