import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/Kehadiran.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final kehadiranProvider = Provider.of<Kehadiran>(context);
    final students = kehadiranProvider.student;

    return Scaffold(
      appBar: AppBar(
          title: Text('Pencatatan Kehadiran'), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(students[index].name),
            trailing: Checkbox(
              value: students[index].isPresent,
              onChanged: (_) => kehadiranProvider.toggleKehadiran(index),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            final isAnyStudentPresent =
                students.any((student) => student.isPresent == true);
            final presentCount = students.where((s) => s.isPresent).length;
            final absentCount = students.length - presentCount;

            if (!isAnyStudentPresent) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pilih siswa terlebih dahulu')),
              );
            } else {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Detail Kehadiran'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Tanggal: ${DateTime.now().toString().split(' ')[0]}'),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Hadir: ${presentCount}'),
                            SizedBox(
                              width: 20,
                            ),
                            Text('Tidak Hadir: ${absentCount}'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Data Kehadiran Siswa:'),
                        SizedBox(
                          height: 10,
                        ),
                        ...students.map<Widget>((student) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${student.name}'),
                              Icon(
                                student.isPresent
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: student.isPresent
                                    ? Colors.green
                                    : Colors.red,
                                size: 18,
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Batal')),
                    TextButton(
                        onPressed: () {
                          kehadiranProvider.saveKehadiran();
                          Navigator.of(ctx).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Kehadiran disimpan!')),
                          );
                        },
                        child: Text('Simpan'))
                  ],
                ),
              );
            }
          },
          child: Text('Simpan Kehadiran'),
        ),
      ),
    );
  }
}
