part of 'database.dart';

class $MascotasTable extends Mascotas with TableInfo<$MascotasTable, Mascota> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MascotasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pesoMeta = const VerificationMeta('peso');
  @override
  late final GeneratedColumn<double> peso = GeneratedColumn<double>(
    'peso',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _edadMeta = const VerificationMeta('edad');
  @override
  late final GeneratedColumn<int> edad = GeneratedColumn<int>(
    'edad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vacunasMeta = const VerificationMeta(
    'vacunas',
  );
  @override
  late final GeneratedColumn<String> vacunas = GeneratedColumn<String>(
    'vacunas',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, tipo, peso, edad, vacunas];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mascotas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Mascota> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('peso')) {
      context.handle(
        _pesoMeta,
        peso.isAcceptableOrUnknown(data['peso']!, _pesoMeta),
      );
    } else if (isInserting) {
      context.missing(_pesoMeta);
    }
    if (data.containsKey('edad')) {
      context.handle(
        _edadMeta,
        edad.isAcceptableOrUnknown(data['edad']!, _edadMeta),
      );
    } else if (isInserting) {
      context.missing(_edadMeta);
    }
    if (data.containsKey('vacunas')) {
      context.handle(
        _vacunasMeta,
        vacunas.isAcceptableOrUnknown(data['vacunas']!, _vacunasMeta),
      );
    } else if (isInserting) {
      context.missing(_vacunasMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mascota map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mascota(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      peso: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peso'],
      )!,
      edad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}edad'],
      )!,
      vacunas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vacunas'],
      )!,
    );
  }

  @override
  $MascotasTable createAlias(String alias) {
    return $MascotasTable(attachedDatabase, alias);
  }
}

class Mascota extends DataClass implements Insertable<Mascota> {
  final int id;
  final String nombre;
  final String tipo;
  final double peso;
  final int edad;
  final String vacunas;
  const Mascota({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.peso,
    required this.edad,
    required this.vacunas,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['tipo'] = Variable<String>(tipo);
    map['peso'] = Variable<double>(peso);
    map['edad'] = Variable<int>(edad);
    map['vacunas'] = Variable<String>(vacunas);
    return map;
  }

  MascotasCompanion toCompanion(bool nullToAbsent) {
    return MascotasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      tipo: Value(tipo),
      peso: Value(peso),
      edad: Value(edad),
      vacunas: Value(vacunas),
    );
  }

  factory Mascota.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mascota(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      tipo: serializer.fromJson<String>(json['tipo']),
      peso: serializer.fromJson<double>(json['peso']),
      edad: serializer.fromJson<int>(json['edad']),
      vacunas: serializer.fromJson<String>(json['vacunas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'tipo': serializer.toJson<String>(tipo),
      'peso': serializer.toJson<double>(peso),
      'edad': serializer.toJson<int>(edad),
      'vacunas': serializer.toJson<String>(vacunas),
    };
  }

  Mascota copyWith({
    int? id,
    String? nombre,
    String? tipo,
    double? peso,
    int? edad,
    String? vacunas,
  }) => Mascota(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    tipo: tipo ?? this.tipo,
    peso: peso ?? this.peso,
    edad: edad ?? this.edad,
    vacunas: vacunas ?? this.vacunas,
  );
  Mascota copyWithCompanion(MascotasCompanion data) {
    return Mascota(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      peso: data.peso.present ? data.peso.value : this.peso,
      edad: data.edad.present ? data.edad.value : this.edad,
      vacunas: data.vacunas.present ? data.vacunas.value : this.vacunas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mascota(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('peso: $peso, ')
          ..write('edad: $edad, ')
          ..write('vacunas: $vacunas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, tipo, peso, edad, vacunas);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mascota &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.tipo == this.tipo &&
          other.peso == this.peso &&
          other.edad == this.edad &&
          other.vacunas == this.vacunas);
}

class MascotasCompanion extends UpdateCompanion<Mascota> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> tipo;
  final Value<double> peso;
  final Value<int> edad;
  final Value<String> vacunas;
  const MascotasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.tipo = const Value.absent(),
    this.peso = const Value.absent(),
    this.edad = const Value.absent(),
    this.vacunas = const Value.absent(),
  });
  MascotasCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String tipo,
    required double peso,
    required int edad,
    required String vacunas,
  }) : nombre = Value(nombre),
       tipo = Value(tipo),
       peso = Value(peso),
       edad = Value(edad),
       vacunas = Value(vacunas);
  static Insertable<Mascota> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? tipo,
    Expression<double>? peso,
    Expression<int>? edad,
    Expression<String>? vacunas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (tipo != null) 'tipo': tipo,
      if (peso != null) 'peso': peso,
      if (edad != null) 'edad': edad,
      if (vacunas != null) 'vacunas': vacunas,
    });
  }

  MascotasCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? tipo,
    Value<double>? peso,
    Value<int>? edad,
    Value<String>? vacunas,
  }) {
    return MascotasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      tipo: tipo ?? this.tipo,
      peso: peso ?? this.peso,
      edad: edad ?? this.edad,
      vacunas: vacunas ?? this.vacunas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (peso.present) {
      map['peso'] = Variable<double>(peso.value);
    }
    if (edad.present) {
      map['edad'] = Variable<int>(edad.value);
    }
    if (vacunas.present) {
      map['vacunas'] = Variable<String>(vacunas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MascotasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('tipo: $tipo, ')
          ..write('peso: $peso, ')
          ..write('edad: $edad, ')
          ..write('vacunas: $vacunas')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MascotasTable mascotas = $MascotasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [mascotas];
}

typedef $$MascotasTableCreateCompanionBuilder =
    MascotasCompanion Function({
      Value<int> id,
      required String nombre,
      required String tipo,
      required double peso,
      required int edad,
      required String vacunas,
    });
typedef $$MascotasTableUpdateCompanionBuilder =
    MascotasCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> tipo,
      Value<double> peso,
      Value<int> edad,
      Value<String> vacunas,
    });

class $$MascotasTableFilterComposer
    extends Composer<_$AppDatabase, $MascotasTable> {
  $$MascotasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get peso => $composableBuilder(
    column: $table.peso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get edad => $composableBuilder(
    column: $table.edad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vacunas => $composableBuilder(
    column: $table.vacunas,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MascotasTableOrderingComposer
    extends Composer<_$AppDatabase, $MascotasTable> {
  $$MascotasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get peso => $composableBuilder(
    column: $table.peso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get edad => $composableBuilder(
    column: $table.edad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vacunas => $composableBuilder(
    column: $table.vacunas,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MascotasTableAnnotationComposer
    extends Composer<_$AppDatabase, $MascotasTable> {
  $$MascotasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<double> get peso =>
      $composableBuilder(column: $table.peso, builder: (column) => column);

  GeneratedColumn<int> get edad =>
      $composableBuilder(column: $table.edad, builder: (column) => column);

  GeneratedColumn<String> get vacunas =>
      $composableBuilder(column: $table.vacunas, builder: (column) => column);
}

class $$MascotasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MascotasTable,
          Mascota,
          $$MascotasTableFilterComposer,
          $$MascotasTableOrderingComposer,
          $$MascotasTableAnnotationComposer,
          $$MascotasTableCreateCompanionBuilder,
          $$MascotasTableUpdateCompanionBuilder,
          (Mascota, BaseReferences<_$AppDatabase, $MascotasTable, Mascota>),
          Mascota,
          PrefetchHooks Function()
        > {
  $$MascotasTableTableManager(_$AppDatabase db, $MascotasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MascotasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MascotasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MascotasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<double> peso = const Value.absent(),
                Value<int> edad = const Value.absent(),
                Value<String> vacunas = const Value.absent(),
              }) => MascotasCompanion(
                id: id,
                nombre: nombre,
                tipo: tipo,
                peso: peso,
                edad: edad,
                vacunas: vacunas,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String tipo,
                required double peso,
                required int edad,
                required String vacunas,
              }) => MascotasCompanion.insert(
                id: id,
                nombre: nombre,
                tipo: tipo,
                peso: peso,
                edad: edad,
                vacunas: vacunas,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MascotasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MascotasTable,
      Mascota,
      $$MascotasTableFilterComposer,
      $$MascotasTableOrderingComposer,
      $$MascotasTableAnnotationComposer,
      $$MascotasTableCreateCompanionBuilder,
      $$MascotasTableUpdateCompanionBuilder,
      (Mascota, BaseReferences<_$AppDatabase, $MascotasTable, Mascota>),
      Mascota,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MascotasTableTableManager get mascotas =>
      $$MascotasTableTableManager(_db, _db.mascotas);
}
