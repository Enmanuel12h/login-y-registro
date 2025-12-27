import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Formularios',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LoginPage(), // La pantalla inicial es el Login
    );
  }
}

// --- PANTALLA DE LOGIN ---
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKeyLogin = GlobalKey<FormState>();
  final userCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  void iniciarSesion() {
    if (_formKeyLogin.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Iniciando sesión...'), backgroundColor: Colors.blue),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKeyLogin,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: userCtrl,
                decoration: const InputDecoration(labelText: 'Usuario', prefixIcon: Icon(Icons.person)),
                validator: (value) => (value == null || value.isEmpty) ? 'Ingrese su usuario' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Contraseña', prefixIcon: Icon(Icons.lock)),
                validator: (value) => (value == null || value.isEmpty) ? 'Ingrese su contraseña' : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: iniciarSesion,
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                child: const Text('Ingresar'),
              ),
              TextButton(
                onPressed: () {
                  // Navegar a la pantalla de Registro
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistroPage()));
                },
                child: const Text('¿No tienes cuenta? Regístrate aquí'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// --- PANTALLA DE REGISTRO ---
class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKeyReg = GlobalKey<FormState>();
  final nombreCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void registrarUsuario() {
    if (_formKeyReg.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos enviados correctamente'), backgroundColor: Colors.green),
      );
      // Regresar al Login después de registrarse
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKeyReg,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(labelText: 'Nombre Full', prefixIcon: Icon(Icons.face)),
                  validator: (v) => (v == null || v.isEmpty) ? 'Campo obligatorio' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: correoCtrl,
                  decoration: const InputDecoration(labelText: 'Correo', prefixIcon: Icon(Icons.email)),
                  validator: (v) => (v == null || !v.contains('@')) ? 'Correo no válido' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Contraseña', prefixIcon: Icon(Icons.security)),
                  validator: (v) => (v == null || v.length < 5) ? 'Mínimo 5 caracteres' : null,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: registrarUsuario,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                  child: const Text('Registrar'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ya tengo cuenta, volver al Login'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}