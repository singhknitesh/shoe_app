import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cart = cartProvider.cart;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  AssetImage(cartItem['image'] as String), // Ensure correct key
              radius: 32,
            ),
            trailing: IconButton(
              onPressed: () {
                cartProvider.removeProduct(cartItem);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
            title: Text(
              cartItem['name'].toString(), // Ensure correct key
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: const Text(
                'Size: Not Specified'), // Modify this according to your data structure
          );
        },
      ),
    );
  }
}
