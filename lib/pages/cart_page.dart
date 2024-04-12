import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce_app/providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // final cart = context.watch<CartProvider>().cart;
    final cart = Provider.of<CartProvider>(context).cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartItem["imageUrl"] as String),
              radius: 30,
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              cartItem["title"].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text("Size : ${cartItem["sizes"].toString()}"),
            trailing: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible:
                        false, // prevent user from clicking outside
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Delete Product",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        content: const Text(
                            "Are you sure you want to remove the product?"),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                // context.read<CartProvider>().removeProduct(cartItem);
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .removeProduct(cartItem);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
