import 'package:admin_dashboard/datatables/products_source.dart';
import 'package:admin_dashboard/providers/products_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productsDTS = ProductsDTS(productsProvider.products, context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Productos', style: CustomLabels.h1),
          const SizedBox(height: 30),

          PaginatedDataTable(
            sortAscending: productsProvider.ascending ,
            sortColumnIndex: productsProvider.sortColumnIndex,
            columns: [
              const DataColumn(label: Text('ID')),
              const DataColumn(label: Text('Imagen')),
              const DataColumn(label: Text('Categoría')),
              DataColumn(label: const Text('Nombre'), onSort: (colIndex, _ ) {
                productsProvider.sortColumnIndex = colIndex;
                productsProvider.sort((product) => product.name);
              }),
              DataColumn(label: const Text('Precio'), onSort: (colIndex, _ ) {
                productsProvider.sortColumnIndex = colIndex;
                productsProvider.sort((product) => product.price);
              }),
             const  DataColumn(label: Text('Acciones')),
            ],
            source: productsDTS,
            header: const Text('Listado de productos'),
            onPageChanged: (page) {

            },
            rowsPerPage: 100,
            actions: [
              CustomIconButton(onPressed: () {
                NavigationService.navigateTo(Flurorouter.newProductRouter);
              }, text: 'Crear producto', icon: Icons.add_outlined, color: const Color.fromARGB(255, 58, 222, 222),)
            ],
          )
        ],
      )
    );
  }
}