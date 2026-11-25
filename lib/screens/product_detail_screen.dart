import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 8.0),
            Text('Harga: Rp ${product.price}'),
            const SizedBox(height: 8.0),
            const Text(
              'Kurir tersedia! Dapat dikirim dalam waktu 4 jam.',
              style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.lightGreen,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Tambah ke Keranjang'),
              onPressed: () {
                keranjang.add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil ditambahkan ke keranjang!'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}