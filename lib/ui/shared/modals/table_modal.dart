// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/table_model.dart';
import 'package:admin_dashboard/providers/tables_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableModal extends StatefulWidget {
  final Tables? table;

  const TableModal({Key? key, this.table}) : super(key: key);

  @override
  State<TableModal> createState() => _TableModalState();
}

class _TableModalState extends State<TableModal> {
  String name = '';
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.table?.id;
    name = widget.table?.name ?? '';
  }
  @override
  Widget build(BuildContext context) {
    final tableProvider = Provider.of<TablesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      width: 300,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.table?.name ?? 'Nueva mesa', style: CustomLabels.h1.copyWith(color: Colors.white)),
              IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close, color: Colors.white))
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          TextFormField(
            onChanged: (value) => name = value,
            validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Ingrese el nombre';
                }
                return null;
              },
            initialValue: widget.table?.name,
            decoration: CustomInputs.loginInputDecoration(
              hint: 'Nombre de la mesa', 
              label: 'Mesa', 
              icon: Icons.deck_outlined
            ),
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlineButton(
              onPressed: () async {
                if(name.isNotEmpty) {
                  if(id == null) {
                    var response = await tableProvider.newTable(name);
                    if(response) {
                      NotificationsService.showSnackBar('Mesa eliminada', false);
                    }
                  } else {
                    var response = await tableProvider.updateTable(name, id!);
                    if(response) {
                      NotificationsService.showSnackBar('Mesa eliminada', false);
                    }
                  }
                  Navigator.of(context).pop();
                } else {
                  NotificationsService.showSnackBar('Debe agregar el nombre', true);
                }
              },
              isTextWhite: true,
              text: 'Guardar',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
    borderRadius:BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: Color.fromARGB(255, 38, 76, 152),
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      )
    ]
  );
}