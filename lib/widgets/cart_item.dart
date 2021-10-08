import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  CartItem(this.id, this.productId, this.title, this.price, this.quantity);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      //comment 1 : here add a message  for delete items from cartlist
      // for apply this property use confirmDismiss
      confirmDismiss: (direction) {
        //comment 2 : showDialog create message
        return showDialog(
          context: context,
          //comment 3 : pass AlertDialog as builder function to create message body
          builder: (ctx) => AlertDialog(
            title: Text('Delete Item'),
            content: Text('Are you sure you want to delete ${title}'),
            actions: [
              FlatButton(
                color: null,
                //comment 4 : for No button use Navigator.of(ctx).pop(false) to cancel last action user do that here last action of user was swipe to left for delete an item of cart list ,
               // Navigator.of(ctx).pop(false) cancel this action of user
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ),
              FlatButton(
                color: null,
                //comment 5 : here Yes , is exactly like No button behavior, The difference is that apply last action of user was swipe to left for delete an item
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.blue.shade800),
                ),
              ),
            ],
          ),
        );
      },
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
