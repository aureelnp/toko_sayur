import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final String? namaUser = args is String ? args : null;
    final String judulAppBar =
        namaUser != null && namaUser.isNotEmpty ? 'Selamat datang, $namaUser' : 'Toko Sayur';

    return Scaffold(
      appBar: AppBar(
        title: Text(judulAppBar),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_bag),
            tooltip: 'Keranjang Belanja',
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('Rp ${products[index].price}'),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/detail',
                arguments: products[index],
              );
            },
          );
        },
      ),
    );
  }
}