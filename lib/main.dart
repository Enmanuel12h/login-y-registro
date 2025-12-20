import 'package:flutter/material.dart';

//  Todo el desarrollo realizado en el archivo main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Actividad Práctica 1',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // [cite: 17] Contador interactivo
  int _contador = 0;

  // [cite: 23] Función para aumentar el contador
  void _incrementar() {
    setState(() {
      _contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // [cite: 25] Adaptación del diseño usando Media Query
    final double ancho = MediaQuery.of(context).size.width;

    return Scaffold(
      //  Scaffold con AppBar
      appBar: AppBar(
        title: const Text('Widgets Avanzados UNIVO'), 
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      //  Column para organizar el contenido verticalmente
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // [cite: 16] Título principal
            const Text(
              'Panel de Control de Usuario',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // Visualización del contador [cite: 17]
            Text(
              'Valor actual: $_contador',
              style: const TextStyle(fontSize: 40, color: Colors.indigo),
            ),
            const SizedBox(height: 40),

            // [cite: 19, 24, 25] Diseño adaptable
            // Si el ancho es menor a 600px, se apilan (Column), si es mayor, se alinean (Row)
            ancho < 600
                ? Column(
                    children: [
                      _infoCard('Sección Informativa A', Icons.info_outline),
                      const SizedBox(height: 15),
                      _infoCard('Sección Informativa B', Icons.help_outline),
                    ],
                  )
                : Row(
                    children: [
                      //  Uso de Expanded para ajustar el tamaño en Row
                      Expanded(child: _infoCard('Sección Informativa A', Icons.info_outline)),
                      const SizedBox(width: 15),
                      Expanded(child: _infoCard('Sección Informativa B', Icons.help_outline)),
                    ],
                  ),
          ],
        ),
      ),
      // [cite: 21, 23] FloatingActionButton para interactividad
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementar,
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // [cite: 18] Widget para las secciones informativas
  Widget _infoCard(String titulo, IconData icono) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.indigo.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icono, size: 40, color: Colors.indigo),
          const SizedBox(height: 10),
          Text(
            titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}