import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart' as d; // Usamos alias para evitar choques con Firebase
import 'firebase_options.dart';
import 'database.dart'; // Nuestra base de datos local

// Instancia global de la base de datos local
final database = AppDatabase();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MascotasApp());
}

class MascotasApp extends StatelessWidget {
  const MascotasApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange), useMaterial3: true),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});
  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  // Controladores para los campos del formulario
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _tipoCtrl = TextEditingController();
  final TextEditingController _pesoCtrl = TextEditingController();
  final TextEditingController _edadCtrl = TextEditingController();

  // Función para Guardar (Create) o Editar (Update)
  void _guardarMascota({Mascota? mascotaExistente}) async {
    final nombre = _nombreCtrl.text;
    final tipo = _tipoCtrl.text;
    final peso = double.tryParse(_pesoCtrl.text) ?? 0.0;
    final edad = int.tryParse(_edadCtrl.text) ?? 0;

    if (mascotaExistente == null) {
      // --- CREATE (Insertar) ---
      // 1. Guardar en Local (Drift)
      await database.insertarMascota(MascotasCompanion.insert(
        nombre: nombre,
        tipo: tipo,
        peso: peso,
        edad: edad,
      ));
      // 2. Guardar en la Nube (Firebase) - Usamos tu colección
      await FirebaseFirestore.instance.collection('jorge_taller').add({
        'nombre': nombre,
        'tipo': tipo,
        'peso': peso,
        'edad': edad,
      });
    } else {
      // --- UPDATE (Actualizar) ---
      // 1. Actualizar en Local (Drift)
      await database.actualizarMascota(Mascota(
        id: mascotaExistente.id,
        nombre: nombre,
        tipo: tipo,
        peso: peso,
        edad: edad,
      ));
      // 2. Actualizar en Firebase (Buscamos por nombre para este ejemplo simple)
      final query = await FirebaseFirestore.instance
          .collection('jorge_taller')
          .where('nombre', isEqualTo: mascotaExistente.nombre)
          .get();
      for (var doc in query.docs) {
        await doc.reference.update({'nombre': nombre, 'tipo': tipo, 'peso': peso, 'edad': edad});
      }
    }

    _limpiarFormulario();
    Navigator.pop(context);
    setState(() {}); // Refrescar UI
  }

  void _limpiarFormulario() {
    _nombreCtrl.clear(); _tipoCtrl.clear(); _pesoCtrl.clear(); _edadCtrl.clear();
  }

  // Ventana flotante para el formulario
  void _mostrarFormulario(Mascota? mascota) {
    if (mascota != null) {
      _nombreCtrl.text = mascota.nombre;
      _tipoCtrl.text = mascota.tipo;
      _pesoCtrl.text = mascota.peso.toString();
      _edadCtrl.text = mascota.edad.toString();
    } else {
      _limpiarFormulario();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(mascota == null ? 'Nueva Mascota' : 'Editar Mascota', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: _tipoCtrl, decoration: const InputDecoration(labelText: 'Tipo (Perro, Gato...)')),
            TextField(controller: _pesoCtrl, decoration: const InputDecoration(labelText: 'Peso'), keyboardType: TextInputType.number),
            TextField(controller: _edadCtrl, decoration: const InputDecoration(labelText: 'Edad'), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _guardarMascota(mascotaExistente: mascota),
              child: Text(mascota == null ? 'Crear' : 'Actualizar'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Mascotas'), centerTitle: true, backgroundColor: Colors.orange),
      body: StreamBuilder<List<Mascota>>(
        // Escuchamos los cambios en la base de datos local en tiempo real
        stream: database.select(database.mascotas).watch(),
        builder: (context, snapshot) {
          final mascotas = snapshot.data ?? [];
          return ListView.builder(
            itemCount: mascotas.length,
            itemBuilder: (context, index) {
              final m = mascotas[index];
              return ListTile(
                leading: const Icon(Icons.pets, color: Colors.orange),
                title: Text(m.nombre),
                subtitle: Text('${m.tipo} • ${m.edad} años • ${m.peso}kg'),
                trailing: IconButton(icon: const Icon(Icons.edit), onPressed: () => _mostrarFormulario(m)),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}