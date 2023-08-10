import 'package:admin_dashboard/datatables/buys_source.dart';
import 'package:admin_dashboard/providers/buys_provider.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/shared/modals/buy_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuysView extends StatefulWidget {
  const BuysView({Key? key}) : super(key: key);

  @override
  State<BuysView> createState() => _BuysView();
}

class _BuysView extends State<BuysView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<BuysProvider>(context, listen: false).getBuys();
  }

  @override
  Widget build(BuildContext context) {
    final buys = Provider.of<BuysProvider>(context).buys;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Text('Compras', style: CustomLabels.h1),
            const SizedBox(height: 30),
            PaginatedDataTable(
              columns: const [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Precio')),
                DataColumn(label: Text('Acciones')),
              ],
              source: BuysDTS(buys, context),
              header: const Text('Listado de compras'),
              onRowsPerPageChanged: (value) => setState(() {
                _rowsPerPage = value ?? 10;
              }),
              rowsPerPage: _rowsPerPage,
              actions: [
                CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context, builder: (_) => const BuyModal());
                  },
                  text: 'Crear compra',
                  icon: Icons.add_outlined,
                  color: const Color.fromARGB(255, 58, 222, 222),
                )
              ],
            )
          ],
        ));
  }
}
