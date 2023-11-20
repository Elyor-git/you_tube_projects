import 'package:flutter/material.dart';

class ShoppingCartIcon extends StatefulWidget {
  const ShoppingCartIcon({super.key});

  @override
  ShoppingCartIconState createState() => ShoppingCartIconState();
}

class ShoppingCartIconState extends State<ShoppingCartIcon> {
  Set<String> get itemsInCart => _itemsInCart;
  Set<String> _itemsInCart = <String>{};

  set itemsInCart(Set<String> value) {
    setState(() {
      _itemsInCart = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasPurchase = itemsInCart.isNotEmpty;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: hasPurchase ? 17.0 : 10.0),
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.black,
          ),
        ),
        if (hasPurchase)
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: CircleAvatar(
              radius: 8.0,
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.white,
              child: Text(
                itemsInCart.length.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
