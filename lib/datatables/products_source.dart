// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:admin_dashboard/models/product_model.dart';
import 'package:admin_dashboard/providers/products_provider.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsDTS extends DataTableSource {
  final List<Products> products;
  final BuildContext context;

  ProductsDTS(this.products, this.context);

  @override
  DataRow? getRow(int index) {
    final productModel = products[index];
    ImageProvider<Object> newImage = const AssetImage('no-image.jpg');

    if(productModel.image.isNotEmpty) {
      Uint8List decodedbytes = base64.decode(productModel.image);
      newImage = Image.memory(decodedbytes).image;
    }

    final productProvider = Provider.of<ProductsProvider>(context, listen: false);

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell( ClipOval(child: Image(image: newImage, width: 35, height: 35)) ),
        DataCell(Text(productModel.category)),
        DataCell(Text(productModel.name)),
        DataCell(Text(productModel.price)),
        DataCell(
          Center(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    NavigationService.navigateTo('/dashboard/product/${productModel.id}');
                  },
                  icon: const Icon(Icons.edit_outlined)
                ),
                const SizedBox(width: 20),
                IconButton(onPressed: () {
                  final dialog = AlertDialog(
                    title: const Text('Borrar'),
                    content: Text('Borrar el producto ${productModel.name}?'),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text('No')),
                      TextButton(onPressed: () async {
                        final response = await productProvider.removeProduct(productModel.id);
                        Navigator.of(context).pop();
                        if(response) {
                          NotificationsService.showSnackBar('Producto eliminado', false);
                        }
                      }, child: const Text('Si')),
                    ],
                  );
                  showDialog(context: context, builder: (_) => dialog );
                }, icon: const Icon(Icons.delete_outline), color: Colors.red.withOpacity(0.7),),
              ],
            ),
          )
        ),
      ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
  
}