import 'package:e_shop/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black87,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final c = provider.carts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(
                c['image'],
              ),
              radius: 30,
            ),
            title:
                Text(c["title"], style: Theme.of(context).textTheme.bodySmall),
            subtitle: Text("Size: ${c['size']}, Price: ${c['price']}"),
            trailing: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                var alert = AlertDialog(
                  title: const Text(
                    "Delete Product",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: const Text("Are you sure want to delete!"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        provider.removeProduct(c);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Successfully Deleted!"),
                            
                          ),
                        );
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                );
                showDialog(
                    context: context,
                    builder: (context) => alert,
                    barrierDismissible: false);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red[400],
              ),
            ),
          );
        },
        itemCount: provider.carts.length,
      ),
    );
  }
}
