import 'package:flutter/material.dart';

import 'server.dart';

class AppState {
  final List<String> productList;
  final Set<String> itemsInCart;

  AppState({
    required this.productList,
    this.itemsInCart = const <String>{},
  });

  AppState copyWith({
    List<String>? productList,
    Set<String>? itemsInCart,
  }) {
    return AppState(
      productList: productList ?? this.productList,
      itemsInCart: itemsInCart ?? this.itemsInCart,
    );
  }
}

class AppStateScope extends InheritedWidget {
  const AppStateScope(this.data, {required Widget child, Key? key})
      : super(key: key, child: child);
  final AppState data;

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data == oldWidget.data;
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({required this.child, super.key});

  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  State<AppStateWidget> createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  AppState _data = AppState(productList: Server.getProductList());

  void setProductList(List<String> newProductList) {
    if (_data.productList != newProductList) {
      setState(() {
        _data = _data.copyWith(productList: newProductList);
      });
    }
  }

  void addToCart(String id) {
    if (!_data.itemsInCart.contains(id)) {
      setState(() {
        final Set<String> newItemsCart = Set<String>.from(_data.itemsInCart);
        newItemsCart.add(id);
        _data = _data.copyWith(itemsInCart: newItemsCart);
      });
    }
  }

  void removeFromCart(String id) {
    if (!_data.itemsInCart.contains(id)) {
      setState(() {
        final Set<String> newItemsCart = Set<String>.from(_data.itemsInCart);
        newItemsCart.remove(id);
        _data = _data.copyWith(itemsInCart: newItemsCart);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(_data, child: widget.child);
  }
}
