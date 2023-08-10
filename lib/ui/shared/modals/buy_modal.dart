// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/buys_model.dart';
import 'package:admin_dashboard/providers/buys_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BuyModal extends StatefulWidget {
  final Buy? table;

  const BuyModal({Key? key, this.table}) : super(key: key);

  @override
  State<BuyModal> createState() => _BuyModalState();
}

class _BuyModalState extends State<BuyModal> {
  String name = '';
  String price = '';
  String date = '';
  String? id;
  TextEditingController dateInput = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    id = widget.table?.id;
    name = widget.table?.name ?? '';
    price = widget.table?.price ?? '';
    date = widget.table?.datesBuy ?? '';
    dateInput.text = widget.table?.datesBuy ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final buysProvider = Provider.of<BuysProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 400,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.table?.name ?? 'Nueva Compra',
                  style: CustomLabels.h1
                      .copyWith(color: const Color.fromARGB(255, 18, 0, 0))),
              IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close,
                      color: Color.fromARGB(255, 7, 0, 0)))
            ],
          ),
          Divider(color: Colors.white.withOpacity(0.3)),
          TextFormField(
            onChanged: (value) => name = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el nombre';
              }
              return null;
            },
            initialValue: widget.table?.name,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Nombre de la compra',
                label: 'Nombre',
                icon: Icons.deck_outlined),
            style: const TextStyle(color: Color.fromARGB(255, 9, 0, 0)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) => price = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el precio';
              }
              return null;
            },
            initialValue: widget.table?.price,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Precio', label: 'Precio', icon: Icons.deck_outlined),
            style: const TextStyle(color: Color.fromARGB(255, 9, 0, 0)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: dateInput,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                setState(() {
                  dateInput.text = formattedDate;
                  date = formattedDate;
                });
              } else {}
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese la fecha';
              }
              return null;
            },
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Fecha', label: 'Fecha', icon: Icons.date_range_rounded),
            style: const TextStyle(color: Color.fromARGB(255, 9, 0, 0)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlineButton(
              onPressed: () async {
                if (name.isNotEmpty || price.isNotEmpty) {
                  if (id == null) {
                    var response =
                        await buysProvider.newBuys(name, price, date);
                    print(response);
                    if (response) {
                      NotificationsService.showSnackBar('Compra creada', false);
                    }
                  } else {
                    var response =
                        await buysProvider.updateBuys(name, price, date, id!);
                    if (response) {
                      NotificationsService.showSnackBar(
                          'Compra actualizada', false);
                    }
                  }
                  Navigator.of(context).pop();
                } else {
                  NotificationsService.showSnackBar(
                      'Debe llenar todos los campos', true);
                }
              },
              isTextWhite: true,
              text: 'Guardar',
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color.fromARGB(255, 58, 222, 222),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
