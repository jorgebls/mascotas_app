import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Enlaza con el archivo que Drift acaba de generar
part 'database.g.dart';

// 1. Definimos la estructura de nuestra tabla local
class Mascotas extends Table {
  IntColumn get id => integer().autoIncrement()(); // ID automático
  TextColumn get nombre => text()();
  TextColumn get tipo => text()();
  RealColumn get peso => real()();
  IntColumn get edad => integer()();
}

// Función para decirle a la app DÓNDE guardar el archivo SQLite en el celular
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db_mascotas.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

// 2. Preparamos la clase principal de la Base de Datos
@DriftDatabase(tables: [Mascotas])
class AppDatabase extends _$AppDatabase {
  
  // Usamos la función de arriba para conectar la base de datos
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- LAS FUNCIONES MÍNIMAS REQUERIDAS POR EL TALLER ---

  // CREATE: Función para Insertar una mascota nueva
  Future<int> insertarMascota(MascotasCompanion mascota) {
    return into(mascotas).insert(mascota);
  }

  // UPDATE: Función para Actualizar una mascota existente
  Future<bool> actualizarMascota(Mascota mascota) {
    return update(mascotas).replace(mascota);
  }
}