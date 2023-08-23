// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/notes_model.dart';
import 'package:admin_dashboard/providers/notes_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_outline_button.dart';
import 'package:admin_dashboard/ui/shared/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotesModal extends StatefulWidget {
  final NotesValue? table;

  const NotesModal({Key? key, this.table}) : super(key: key);

  @override
  State<NotesModal> createState() => _NotesModalState();
}

class _NotesModalState extends State<NotesModal> {
  String title = '';
  String details = '';
  String date = '';
  String? id;
  TextEditingController dateInput = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    id = widget.table?.id;
    title = widget.table?.title ?? '';
    details = widget.table?.details ?? '';
    date = widget.table?.dates ?? '';
    dateInput.text = widget.table?.dates ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(20),
      height: 450,
      width: double.infinity,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.table?.title ?? 'Nueva Nota',
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
            onChanged: (value) => title = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese el Título';
              }
              return null;
            },
            initialValue: widget.table?.title,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Mesa o persona',
                label: 'Título',
                icon: Icons.deck_outlined),
            style: const TextStyle(color: Color.fromARGB(255, 9, 0, 0)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            maxLines: 4,
            keyboardType: TextInputType.number,
            onChanged: (value) => details = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese los detalles';
              }
              return null;
            },
            initialValue: widget.table?.details,
            decoration: CustomInputs.loginInputDecoration(
                hint: 'Descripción...', label: 'Detalles', icon: Icons.deck_outlined),
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
                if (title.isNotEmpty || details.isNotEmpty) {
                  if (id == null) {
                    var response =
                        await notesProvider.newNotes(title, details, date);
                    if (response) {
                      NotificationsService.showSnackBar('Nota creada', false);
                    }
                  } else {
                    var response =
                        await notesProvider.updateNotes(title, details, date, id!);
                    if (response) {
                      NotificationsService.showSnackBar(
                          'Nota actualizada', false);
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
