import 'dart:math';
import 'package:admin_dashboard/datatables/orders_source.dart';
import 'package:admin_dashboard/models/table_model.dart';
import 'package:admin_dashboard/providers/orders_provider.dart';
import 'package:admin_dashboard/providers/sales_provider.dart';
import 'package:admin_dashboard/providers/tables_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersState();
}

class _OrdersState extends State<OrdersView> {
  List<Tables> listTables = [];
  String title = '';
  String tableId = '';
  bool showTable = false;
  bool payWithCard = false;
  final oCcy = NumberFormat.simpleCurrency();
  
  @override
  void initState() {
    super.initState();
    Provider.of<TablesProvider>(context, listen: false).getTables();
    Provider.of<OrdersProvider>(context, listen: false).getPercent();
  }
  set string(String value) => setState(() => title = value);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrdersProvider>(context);
    final providerSales = Provider.of<SalesProvider>(context);
    final tablesProvider = Provider.of<TablesProvider>(context);
    final productsDTS = OrdersDTS(provider.products, context, title);
    listTables = tablesProvider.tables;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _menuOrder(provider, providerSales, productsDTS),
        _buttonsWidget(provider),
      ],
    );
  }

  Expanded _menuOrder(OrdersProvider provider, SalesProvider providerSales, OrdersDTS productsDTS) {
    final yourScrollController = ScrollController();
    return Expanded(
        child: SizedBox(
          height: double.infinity,
          child: Scrollbar(
            controller: yourScrollController,
            thumbVisibility: false, 
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 400,
                    child: Wrap(
                      runSpacing: 10,
                      spacing: 10,
                      children: <Widget>[
                          for(var item in listTables ) FloatingActionButton.extended(
                            heroTag: 'ordersNew_${item}_${Random().nextInt(5000)}',
                            //backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                            onPressed: () {
                              setState(() {
                                showTable = true;
                                title = item.name;
                                tableId = item.id;
                                provider.getOrders(title);
                              });
                            }, 
                            label: Text(item.name)
                          )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(showTable ? title : 'Seleccione una mesa', style: CustomLabels.h1),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    child: Wrap(
                      runSpacing: 20,
                      spacing: 20,
                      children: <Widget>[
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 13, 110, 63),
                                minimumSize: const Size(120, 50)
                              ),
                              onPressed: () {
                                final dialog = AlertDialog(
                                  content: const Text('Cerrar la venta del día?'),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.pop(context);
                                    }, child: const Text('No')),
                                    TextButton(onPressed: () async {
                                      providerSales.saveTodaySales();
                                      NotificationsService.showSnackBar('Total del día guardado', false);
                                      Navigator.of(context).pop();
                                    }, child: const Text('Si')),
                                  ],
                                );
                                showDialog(context: context, builder: (_) => dialog );
                              }, 
                              child: const Text('Cerrar venta diaría', style: TextStyle(color: Colors.white),)
                            ),
                          ],
                        ),
                        if(showTable)
                          PaginatedDataTable(
                            columnSpacing: 10.0,
                            sortAscending: provider.ascending ,
                            sortColumnIndex: provider.sortColumnIndex,
                            columns: [
                              DataColumn(label: const Text('Categoría'), onSort: (colIndex, _ ) {
                                provider.sortColumnIndex = colIndex;
                                provider.sort((product) => product.category);
                              }),
                              DataColumn(label: const Text('Nombre'), onSort: (colIndex, _ ) {
                                provider.sortColumnIndex = colIndex;
                                provider.sort((product) => product.name);
                              }),
                              DataColumn(label: const Text('Precio'), onSort: (colIndex, _ ) {
                                provider.sortColumnIndex = colIndex;
                                provider.sort((product) => product.price);
                              }),
                            const  DataColumn(label: Text('Acciones')),
                            ],
                            source: productsDTS,
                            rowsPerPage: 100,
                            header: const Text('Listado de productos'),
                            onPageChanged: (page) {},
                          )
                      ],
                    ),
                  ),
                ),
              ],
            )
          )
        ),
      );
  }

  Container _buttonsWidget(OrdersProvider provider) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Color.fromARGB(255, 7, 21, 21),
            width: 2.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Column(
              children: [
                if(showTable)
                  SizedBox(
                    width: 300,
                    child: Center(
                      child: Column(
                        children: [
                          Text('Pedido $title', style: CustomLabels.h2),
                          DataTable(
                            dataRowHeight: 35,
                            columnSpacing: 30,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Producto',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Cantidad',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Valor',
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                            rows: provider.orders.map((itemRow) => DataRow(
                                cells: [
                                  DataCell(Text(itemRow.name)),
                                  DataCell(Text(itemRow.count)),
                                  DataCell(Text(oCcy.format(int.parse(itemRow.price)))),
                                ],
                              ),
                            ).toList(),
                          ),
                          const Divider(),
                          if(provider.totalCurrency != '\$0.00' && provider.totalCurrency != '0')
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 13, 110, 63),),
                              onPressed: () {
                                final dialog = AlertDialog(
                                  title: payWithCard 
                                    ? Text('- ${provider.totalPre}\n% ${provider.totalPercent}\nTotal ${provider.totalCurrency}')
                                    : Text('Total ${provider.totalCurrency}'),
                                  content: Text('Cerrar la mesa: $title?'),
                                  actions: [
                                    TextButton(onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: const Text('No')),
                                    TextButton(onPressed: () async {
                                      provider.saveOrderTotal(title, provider.totalPre, tableId);
                                      Navigator.of(context).pop();
                                      setState(() {
                                        payWithCard = false;
                                        showTable = false;
                                        title = '';
                                      });
                                    }, child: const Text('Si')),
                                  ],
                                );
                                showDialog(context: context, builder: (_) => dialog );
                              }, 
                              child: payWithCard ? Text(provider.totalCurrency) : Text(provider.totalCurrency)
                            ),

                          if(provider.orders.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  FloatingActionButton(
                                    tooltip: "Pago con tarjeta",
                                    backgroundColor: payWithCard ? Colors.blue.shade700 : Colors.grey,
                                    highlightElevation: 50,
                                    focusElevation: 10,
                                    child: Icon(payWithCard ? Icons.credit_card_outlined : Icons.credit_card_off_outlined),
                                    onPressed: () {
                                      setState(() {
                                        payWithCard = !payWithCard;
                                        if(payWithCard) {
                                          provider.setTotalPercent(provider.cardPercent);
                                        } else {
                                          provider.setTotalPercent(0);
                                        }
                                      });
                                    }
                                  ),
                                ],
                              )
                            )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
