import 'package:flutter/material.dart';
import 'book.dart'; // for Book model

class CartPage extends StatelessWidget {
  final List<Book> cartBooks;
  final int total;

  const CartPage({
    super.key,
    required this.cartBooks,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: cartBooks.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartBooks.length,
                    itemBuilder: (context, index) {
                      final book = cartBooks[index];

                      return ListTile(
                        leading: Image.asset(
                          book.image,
                          height: 50,
                        ),
                        title: const Text("Book"),
                        trailing: Text("₹${book.price}"),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹$total",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
