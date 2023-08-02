// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/category_model.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryModal extends StatefulWidget {
  final Category? table;

  const CategoryModal({Key? key, this.table}) : super(key: key);

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
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
    final categoriesProvider = Provider.of<CategoriesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.table?.name ?? 'Nueva categoría', style: CustomLabels.h1.copyWith(color: const Color.fromARGB(255, 18, 0, 0))),
              IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close, color: Color.fromARGB(255, 7, 0, 0)))
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
              hint: 'Nombre de la categoría', 
              label: 'Categoría', 
              icon: Icons.deck_outlined
            ),
            style: const TextStyle(color: Color.fromARGB(255, 9, 0, 0)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: CustomOutlineButton(
              onPressed: () async {
                if(name.isNotEmpty) {
                  if(id == null) {
                    var response = await categoriesProvider.newCategory(name);
                    if(response) {
                      NotificationsService.showSnackBar('Categoría creada', false);
                    }
                  } else {
                    var response = await categoriesProvider.updateCategory(name, id!);
                    if(response) {
                      NotificationsService.showSnackBar('Categoría actualizada', false);
                    }
                  }
                  Navigator.of(context).pop();
                } else {
                  NotificationsService.showSnackBar('Debe agregar el nombre', true);
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
    borderRadius:BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    color: Color.fromARGB(255, 58, 222, 222),
    boxShadow: [
      BoxShadow(
        color: Colors.black26
      )
    ]
  );
}