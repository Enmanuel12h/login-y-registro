import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parcial 1 - UNIVO',
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Principal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            menuCard(context, 'Lista de Súper', Icons.shopping_cart, const SuperPage()),
            menuCard(context, 'Clima', Icons.wb_sunny, const ClimaPage()),
            menuCard(context, 'Fecha y Hora', Icons.timer, const HoraPage()),
            menuCard(context, 'Agenda', Icons.contact_phone, const AgendaPage()),
          ],
        ),
      ),
    );
  }

  Widget menuCard(BuildContext context, String titulo, IconData icono, Widget pagina) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pagina),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 50, color: Colors.blue),
            const SizedBox(height: 10),
            Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class SuperPage extends StatelessWidget {
  const SuperPage({super.key});

  final List<Map<String, dynamic>> productos = const [
    {'nombre': 'Arroz', 'icono': Icons.rice_bowl},
    {'nombre': 'Leche', 'icono': Icons.local_drink},
    {'nombre': 'Pan', 'icono': Icons.bakery_dining},
    {'nombre': 'Huevos', 'icono': Icons.egg},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Súper')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(productos[index]['icono']),
                  title: Text(productos[index]['nombre']),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Regresar'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ClimaPage extends StatelessWidget {
  const ClimaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clima')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud, size: 100, color: Colors.grey),
            const Text('24°C', style: TextStyle(fontSize: 40)),
            const Text('Nublado', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}

class HoraPage extends StatefulWidget {
  const HoraPage({super.key});

  @override
  State<HoraPage> createState() => _HoraPageState();
}

class _HoraPageState extends State<HoraPage> {
  late Timer _timer;
  DateTime _fechaHoraActual = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _fechaHoraActual = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fecha y Hora')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time, size: 80),
            const SizedBox(height: 20),
            Text(
              '${_fechaHoraActual.day}/${_fechaHoraActual.month}/${_fechaHoraActual.year}',
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              '${_fechaHoraActual.hour}:${_fechaHoraActual.minute.toString().padLeft(2, '0')}:${_fechaHoraActual.second.toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Regresar'),
            ),
          ],
        ),
      ),
    );
  }
}

class AgendaPage extends StatelessWidget {
  const AgendaPage({super.key});

  final List<Map<String, String>> contactos = const [
    {'nombre': 'Enmanuel Mejia', 'telefono': '7890-1234'},
    {'nombre': 'Ing. William', 'telefono': '7123-4567'},
    {'nombre': 'Carlos Ruiz', 'telefono': '7012-9876'},
    {'nombre': 'Pedro Sanchez', 'telefono': '7123-4567'},
    {'nombre': 'Pablo Martinez', 'telefono': '7012-9876'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda Telefónica')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contactos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(contactos[index]['nombre']!),
                  subtitle: Text(contactos[index]['telefono']!),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Regresar'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}