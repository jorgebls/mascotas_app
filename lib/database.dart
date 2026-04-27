import 'package:drift/drift.dart';
import 'package:drift/web.dart';

part 'database.g.dart';

class Mascotas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get tipo => text()();
  RealColumn get peso => real()();
  IntColumn get edad => integer()();
  TextColumn get vacunas => text()(); // El nuevo campo
}

@DriftDatabase(tables: [Mascotas])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(WebDatabase('db_mascotas'));

  @override
  int get schemaVersion => 2;

  // --- ¡AQUÍ ESTÁN LAS FUNCIONES! ---
  Future<int> insertarMascota(MascotasCompanion mascota) =>
      into(mascotas).insert(mascota);

  // ESTA ES LA LÍNEA QUE FALTABA PARA QUE SE QUITE EL ERROR ROJO:
  Future<bool> actualizarMascota(Mascota mascota) =>
      update(mascotas).replace(mascota);

  Future<List<Mascota>> obtenerTodas() => select(mascotas).get();
}
