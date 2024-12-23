import 'package:flutter/material.dart';

class DetailHistory extends StatefulWidget {
  final DateTime date;
  final List<Map<String, dynamic>> students;
  const DetailHistory({super.key, required this.date, required this.students});

  @override
  State<DetailHistory> createState() => _DetailHistoryState();
}

class _DetailHistoryState extends State<DetailHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail '),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: widget.students.length,
        itemBuilder: (context, index) {
          final student = widget.students[index];
          return ListTile(
            title: Text(student['name']),
            trailing: Icon(
              student['isPresent'] ? Icons.check_circle : Icons.cancel,
              color: student['isPresent'] ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
