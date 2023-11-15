import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});


  @override
  State<BottomNav> createState() =>
      _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  // Halaman-halaman yang akan ditampilkan
  final List<Widget> _pages = [
    const HomePage(),
    const KegiatanPage(),
    const JadwalPage(),
    const InputPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universitas Logistik dan Bisnis Internasional'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.yellow,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Kegiatan',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Jadwal',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Input Kegiatan',
            backgroundColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}

// Kelas AboutPage yang baru ditambahkan


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bagian kiri dengan foto profil
            CircleAvatar(
              backgroundImage: NetworkImage('https://raw.githubusercontent.com/Befous/images/b03e9cc66b33ecdf27277c88640787b12e49273b/ibrohim.jpg'), // Sesuaikan dengan path foto profil Anda
              radius: 50.0, // Sesuaikan dengan ukuran yang diinginkan
            ),
            SizedBox(width: 16.0), // Jarak antara foto profil dan teks profil

            // Bagian kanan dengan teks profil
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nama: Ibrohim Mubarok',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'NPM: 1214081',
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  'Jurusan: Teknik Informatika',
                  style: TextStyle(fontSize: 16.0),
                ),
                // Tambahkan informasi profil lainnya sesuai kebutuhan
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class KegiatanPage extends StatefulWidget {
  const KegiatanPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _KegiatanPage createState() => _KegiatanPage();
}

class _KegiatanPage extends State<KegiatanPage> {
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://asia-southeast2-befous.cloudfunctions.net/Befous-AmbilDataKegiatan'),
        // Ganti 'URL_API_ANDA_DI_SINI' dengan URL sesuai kebutuhan Anda
      );

      if (response.statusCode == 200) {
        // Jika respons HTTP berhasil (kode status 200)
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          dataList = List<Map<String, dynamic>>.from(jsonData);
        });
      }
      // ignore: empty_catches
    } catch (error) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 25),
            // Tambahkan spasi di atas judul
            const Text(
              'List Kegiatan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Tambahkan spasi antara judul dan tabel
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Nama')),
                    DataColumn(label: Text('Note')),
                    DataColumn(label: Text('Tanggal')),
                  ],
                  rows: dataList.map((data) {
                    return DataRow(cells: [
                      DataCell(Text('${data['id']}')),
                      DataCell(Text('${data['nama']}')),
                      DataCell(Text('${data['note']}')),
                      DataCell(Text('${data['tanggal']}')),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JadwalPage extends StatefulWidget {
  const JadwalPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _JadwalPage createState() => _JadwalPage();
}

class _JadwalPage extends State<JadwalPage> {
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://asia-southeast2-befous.cloudfunctions.net/Befous-AmbilDataJadwal'),
        // Ganti 'URL_API_ANDA_DI_SINI' dengan URL sesuai kebutuhan Anda
      );

      if (response.statusCode == 200) {
        // Jika respons HTTP berhasil (kode status 200)
        final List<dynamic> jsonData = json.decode(response.body);
        setState(() {
          dataList = List<Map<String, dynamic>>.from(jsonData);
        });
      }
      // ignore: empty_catches
    } catch (error) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 25),
            // Tambahkan spasi di atas judul
            const Text(
              'Jadwal Kuliah',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Tambahkan spasi antara judul dan tabel
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('Mata Kuliah')),
                    DataColumn(label: Text('Hari')),
                    DataColumn(label: Text('Jam')),
                  ],
                  rows: dataList.map((data) {
                    return DataRow(cells: [
                      DataCell(Text('${data['id']}')),
                      DataCell(Text('${data['nama']}')),
                      DataCell(Text('${data['hari']}')),
                      DataCell(Text('${data['jam']}')),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Map<String, dynamic>> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            // Tambahkan spasi di atas judul
            const Text(
              'Input Kegiatan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Tambahkan spasi antara judul dan tabel
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(labelText: 'Note'),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Tanggal'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addData();
              },
              child: const Text('Input Data'),
            ),
            const SizedBox(height: 16.0),
            DataTable(
              columns: const [
                DataColumn(label: Text('Nama')),
                DataColumn(label: Text('Note')),
                DataColumn(label: Text('Tanggal')),
              ],
              rows: dataList.map((data) {
                return DataRow(cells: [
                  DataCell(Text('${data['nama']}')),
                  DataCell(Text('${data['note']}')),
                  DataCell(Text('${data['tanggal']}')),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
  void _addData() {
    setState(() {
      dataList.add({
        'nama': nameController.text,
        'note': noteController.text,
        'tanggal': dateController.text,
      });

      // Clear the text controllers after adding data
      nameController.clear();
      noteController.clear();
      dateController.clear();
    });
  }
}



void main() {
  runApp(const MaterialApp(
      home: BottomNav(),
      ));
}