import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detail_history.dart';
import 'package:flutter_application_1/providers/Kehadiran.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kehadiranProvider = Provider.of<Kehadiran>(context);
    final historyKehadiran = kehadiranProvider.historyKehadiran;
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Kehadiran'),
        backgroundColor: Colors.blue,
      ),
      body: historyKehadiran.isEmpty
          ? Center(child: Text('Belum ada riwayat kehadiran.'))
          : ListView.builder(
              itemCount: historyKehadiran.length,
              itemBuilder: (context, index) {
                final record = historyKehadiran[index];
                return ListTile(
                  title: Text(
                    'Tanggal: ${record['date'].toString().split(' ')[0]}',
                  ),
                  subtitle: Text(
                    'Hadir: ${record['present']}, Tidak Hadir: ${record['absent']}',
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailHistory(
                        date: record['date'],
                        students: record['students'],
                      ),
                    ));
                  },
                );
              },
            ),
    );
  }
}
