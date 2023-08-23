import 'package:admin_dashboard/datatables/notes_source.dart';
import 'package:admin_dashboard/providers/notes_provider.dart';
import 'package:admin_dashboard/ui/shared/buttons/custom_icon_button.dart';
import 'package:admin_dashboard/ui/shared/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/shared/modals/notes_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _BuysView();
}

class _BuysView extends State<NotesView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context, listen: false).getNotes();
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<NotesProvider>(context).notes;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('Notas', style: CustomLabels.h1),
          const SizedBox(height: 30),
          PaginatedDataTable(
            dataRowMinHeight: 20,
            dataRowMaxHeight: 120,
            columns: const [
              DataColumn(label: Text('Título')),
              DataColumn(label: Text('Fecha')),
              DataColumn(label: Text('Nota')),
              DataColumn(label: Text('Acciones')),
            ],
            source: NotesDTS(notes, context),
            header: const Text('Listado de notas'),
            onRowsPerPageChanged: (value) => setState(() {
              _rowsPerPage = value ?? 50;
            }),
            rowsPerPage: _rowsPerPage,
            actions: [
              CustomIconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: (_) => const NotesModal());
                },
                text: 'Crear nota',
                icon: Icons.add_outlined,
                color: const Color.fromARGB(255, 58, 222, 222),
              )
            ],
          )
        ],
      )
    );
  }
}
