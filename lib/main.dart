import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'database.dart';

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
      title: 'Registro Mascotas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
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
  void _mostrarFormulario([Mascota? mascotaExistente]) {
    final nombreController = TextEditingController(
      text: mascotaExistente?.nombre ?? '',
    );
    final tipoController = TextEditingController(
      text: mascotaExistente?.tipo ?? '',
    );
    final pesoController = TextEditingController(
      text: mascotaExistente?.peso.toString() ?? '',
    );
    final edadController = TextEditingController(
      text: mascotaExistente?.edad.toString() ?? '',
    );

    List<String> opcionesVacunas = [
      'Rabia',
      'Parvovirus',
      'Moquillo',
      'Hepatitis',
      'Leptospirosis',
    ];
    List<String> seleccionadas = [];
    if (mascotaExistente != null && mascotaExistente.vacunas.isNotEmpty) {
      seleccionadas = mascotaExistente.vacunas.split(', ').toList();
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text(
                mascotaExistente == null
                    ? 'Registrar Nueva Mascota'
                    : 'Editar Mascota',
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nombreController,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    TextField(
                      controller: tipoController,
                      decoration: const InputDecoration(
                        labelText: 'Tipo (Perro, Gato...)',
                      ),
                    ),
                    TextField(
                      controller: pesoController,
                      decoration: const InputDecoration(labelText: 'Peso (kg)'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: edadController,
                      decoration: const InputDecoration(
                        labelText: 'Edad (años)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 25),
                    const Text(
                      'Vacunas Aplicadas:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),

                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: opcionesVacunas.map((v) {
                        final estaSeleccionada = seleccionadas.contains(v);
                        return FilterChip(
                          label: Text(v),
                          selected: estaSeleccionada,
                          selectedColor: Colors.green,
                          checkmarkColor: Colors.white,
                          backgroundColor: Colors.white,
                          shape: const StadiumBorder(
                            side: BorderSide(color: Colors.black12),
                          ),
                          onSelected: (bool selected) {
                            setDialogState(() {
                              if (selected) {
                                seleccionadas.add(v);
                              } else {
                                seleccionadas.remove(v);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  onPressed: () async {
                    final nombre = nombreController.text;
                    final tipo = tipoController.text;
                    final peso = double.tryParse(pesoController.text) ?? 0.0;
                    final edad = int.tryParse(edadController.text) ?? 0;
                    final vacunasTexto = seleccionadas.join(', ');

                    if (mascotaExistente == null) {
                      // --- CREATE (Sin fecha) ---
                      await database.insertarMascota(
                        MascotasCompanion.insert(
                          nombre: nombre,
                          tipo: tipo,
                          peso: peso,
                          edad: edad,
                          vacunas: vacunasTexto,
                        ),
                      );
                      await FirebaseFirestore.instance
                          .collection('jorge_taller')
                          .add({
                            'nombre': nombre,
                            'tipo': tipo,
                            'peso': peso,
                            'edad': edad,
                            'vacuna': seleccionadas,
                          });
                    } else {
                      // --- UPDATE (Sin fecha) ---
                      await database.actualizarMascota(
                        Mascota(
                          id: mascotaExistente.id,
                          nombre: nombre,
                          tipo: tipo,
                          peso: peso,
                          edad: edad,
                          vacunas: vacunasTexto,
                        ),
                      );
                      final query = await FirebaseFirestore.instance
                          .collection('jorge_taller')
                          .where('nombre', isEqualTo: mascotaExistente.nombre)
                          .get();
                      for (var doc in query.docs) {
                        await doc.reference.update({
                          'nombre': nombre,
                          'tipo': tipo,
                          'peso': peso,
                          'edad': edad,
                          'vacuna': seleccionadas,
                        });
                      }
                    }

                    if (context.mounted) {
                      Navigator.pop(context);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            mascotaExistente == null
                                ? 'Mascota registrada'
                                : 'Mascota actualizada',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro de Mascotas',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<List<Mascota>>(
        stream: database.select(database.mascotas).watch(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final mascotas = snapshot.data!;
          if (mascotas.isEmpty) {
            return const Center(
              child: Text('No hay mascotas registradas aún.'),
            );
          }

          return ListView.builder(
            itemCount: mascotas.length,
            itemBuilder: (context, index) {
              final m = mascotas[index];
              int cantidadVacunas = m.vacunas.isEmpty
                  ? 0
                  : m.vacunas.split(', ').length;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                elevation: 2,
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.orange,
                        child: Icon(Icons.pets, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    m.nombre,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => _mostrarFormulario(m),
                                ),
                              ],
                            ),
                            Divider(color: Colors.orange.shade200, height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'TIPO',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        m.tipo,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'EDAD',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${m.edad} años',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PESO',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${m.peso} kg',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'VACUNAS',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '($cantidadVacunas) ',
                                            ),
                                            const TextSpan(
                                              text: '✅',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarFormulario(),
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Nueva Mascota',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
