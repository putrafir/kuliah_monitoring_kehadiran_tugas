import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Student.dart';

class Kehadiran with ChangeNotifier {
  final List<Student> _student = [
    Student(name: 'Ali'),
    Student(name: 'Budi'),
    Student(name: 'Citra'),
    Student(name: 'Putra'),
    Student(name: 'Reza')
  ];

  final List<Map<String, dynamic>> _historyKehadiran = [];

  List<Student> get student => _student;

  List<Map<String, dynamic>> get historyKehadiran => _historyKehadiran;

  void toggleKehadiran(int index) {
    _student[index].isPresent = !_student[index].isPresent;
    notifyListeners();
  }

  void saveKehadiran() {
    final presentCount = _student.where((s) => s.isPresent).length;
    final absentCount = student.length - presentCount;

    _historyKehadiran.insert(0, {
      'date': DateTime.now(),
      'present': presentCount,
      'absent': absentCount,
      'students': _student
          .map(
            (student) => {
              'name': student.name,
              'isPresent': student.isPresent,
            },
          )
          .toList()
    });

    for (var student in _student) {
      if (student.name != 'Putra' && student.name != 'Reza') {
        student.isPresent = false;
      }
    }

    notifyListeners();
  }
}
