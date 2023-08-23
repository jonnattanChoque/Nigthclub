// ignore_for_file: use_build_context_synchronously

import 'package:admin_dashboard/models/notes_model.dart';
import 'package:admin_dashboard/providers/notes_provider.dart';
import 'package:admin_dashboard/services/notifications_service.dart';
import 'package:admin_dashboard/ui/shared/modals/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final oCcy = NumberFormat.simpleCurrency();

class NotesDTS extends DataTableSource {
  final List<NotesValue> notes;
  final BuildContext context;

  NotesDTS(this.notes, this.context);

  @override
  DataRow? getRow(int index) {
    List<Text> textos = [];
    final noteModel = notes[index];
    final tableProvider = Provider.of<NotesProvider>(context, listen: false);
    final List<String> splitNames = noteModel.details.split(',');
    
    for (var text in splitNames) {
      textos.add(Text(text));
    }
    return DataRow.byIndex(index: index, cells: [
      DataCell(Text(noteModel.title)),
      DataCell(Text(noteModel.dates)),
      DataCell(Wrap(direction: Axis.vertical,
          spacing: 2, children: textos)),
      DataCell(Center(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => NotesModal(table: noteModel));
                },
                icon: const Icon(Icons.edit_outlined)),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Borrar'),
                  content: Text('Borrar la nota ${noteModel.title} ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () async {
                          final response =
                              await tableProvider.removeNotes(noteModel.id);
                          Navigator.of(context).pop();
                          if (response) {
                            NotificationsService.showSnackBar(
                                'Nota eliminada', false);
                          }
                        },
                        child: const Text('Si')),
                  ],
                );
                showDialog(context: context, builder: (_) => dialog);
              },
              icon: const Icon(Icons.delete_outline),
              color: Colors.red.withOpacity(0.7),
            ),
          ],
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => notes.length;

  @override
  int get selectedRowCount => 0;
}
