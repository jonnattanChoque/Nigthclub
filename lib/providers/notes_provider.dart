import 'package:admin_dashboard/models/notes_model.dart';
import 'package:admin_dashboard/services/back_servie.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

class NotesProvider extends ChangeNotifier with BackService {
  List<NotesValue> notes = [];
  bool ascending = true;
  int? sortColumnIndex;

  NotesProvider() {
    initializeDateFormatting();
  }

  getNotes() async {
    final json = await getData('bar/notes');
    notes = await NoteResponse().jsonDecodes(json);
    notifyListeners();
  }

  DateTime toDateTime(int d) {
    var dt=DateTime.fromMillisecondsSinceEpoch(d);
    return DateTime(dt.year, dt.month, dt.day);
  }

  newNotes(String title, String detail, String date) async {
    final data = {"title": title, "details": detail, "dates": date};
    final response = await newData(data, 'bar/notes', null);
    final newTable = await NoteResponse().jsonDecodeSingle(response);
    if (newTable != null) {
      notes.add(newTable);
      getNotes();
      return true;
    } else {
      return false;
    }
  }

  updateNotes(String title, String detail, String date, String id) async {
    if (title.isNotEmpty) {
      final data = {"id": id, "title": title, "details": detail, "dates": date};
      final response = await updateData(data, 'bar/notes/$id');
      final updateTable = await NoteResponse().jsonDecodeSingle(response);
      if (updateTable != null) {
        final index = notes.indexWhere((table) => table.id == id);
        notes[index] = updateTable;
        getNotes();
        return true;
      } else {
        return false;
      }
    }
  }

  removeNotes(String id) async {
    if (id.isNotEmpty) {
      final response = removeData('bar/notes/$id');
      final index = notes.indexWhere((table) => table.id == id);
      notes.removeAt(index);
      getNotes();
      return response;
    }
  }
}


extension ListExtensions<T> on List<T> {
  Iterable<T> whereWithIndex(bool Function(T element, int index) test) {
    final List<T> result = [];
    // ignore: unnecessary_this
    for (var i = 0; i < this.length; i++) {
      if (test(this[i], i)) {
        result.add(this[i]);
      }
    }
    return result;
  }
}