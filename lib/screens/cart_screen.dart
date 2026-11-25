import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  void hapusItem(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Hapus item ini dari keranjang?'),
              const SizedBox(height: 12),
              ElevatedButton(
                child: const Text('Hapus'),
                onPressed: () {
                  setState(() {
                    keranjang.removeAt(index);
                  });
                  Navigator.pop(sheetContext);
                },
              ),
              TextButton(
                child: const Text('Batal'),
                onPressed: () => Navigator.pop(sheetContext),
              ),
            ],
          ),
        );
      },
    );
  }

  void bayar() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_bag,
                size: 64,
                color: Colors.green,
              ),
              const SizedBox(height: 12),
              const Text(
                'Lanjut ke pembayaran?',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        keranjang.clear();
                      });
                      Navigator.pop(sheetContext);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pembayaran berhasil!')),
                      );
                    },
                    child: const Text('Lanjut'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _konfirmasiKeluarKeranjang() async {
    final keluar = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: const Text('Tinggalkan keranjang?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );

    if (keluar == true && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: keranjang.isEmpty,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) return;
        await _konfirmasiKeluarKeranjang();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Keranjang'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
          itemCount: keranjang.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(keranjang[index].name),
              subtitle: Text('Rp ${keranjang[index].price}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  hapusItem(index);
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Bayar'),
          icon: const Icon(Icons.payment),
          onPressed: () {
            bayar();
          },
        ),
      ),
    );
  }
}