import 'dart:convert';
import 'package:control_de_calidad/Configuraciones/Configuraciones.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/formulariocolorante.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_ctrl_MP.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_ctrl_pesos.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_defectos.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_procesos.dart';
import 'package:control_de_calidad/Ventanas/preformas%20ips/screen_temperaturas.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';


import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class DatosProviderPrefIPS with ChangeNotifier {
  late Database _db;   
  final String tableDatosPROCEIPS = 'DatosProceips';
  final String tableDatosPESOSIPS = 'datosPESOSIPS';
  final String tableDatosMPIPS = 'datosMpIps';
  final String tableDatosDEFIPS = 'datosDefIps';
  final String tableDatosTEMPIPS = 'datosTempips';
  final String tableDatosColoranteIPS = 'DatoscoloranteIPS';

 
  List<DatosPROCEIPS> _datosproceipsList = [];
  List<DatosPESOSIPS> _datospesosipsList = [];
  List<DatosMPIPS> _datosmpipsList = [];
  List<DatosDEFIPS> _datosdefipsList = [];
  List<DatosTEMPIPS> _datostempipsList = [];
  List<DatosColoranteIPS> _datoscoloranteipsList = [];
  

  List<DatosPROCEIPS> get datosproceipsList => List.unmodifiable(_datosproceipsList);
  List<DatosPESOSIPS> get datospesosipsList => List.unmodifiable(_datospesosipsList);
  List<DatosMPIPS> get datosmpipsList => List.unmodifiable(_datosmpipsList);
  List<DatosDEFIPS> get datosdefipsList => List.unmodifiable(_datosdefipsList);
  List<DatosTEMPIPS> get datostempipsList => List.unmodifiable(_datostempipsList);
  List<DatosColoranteIPS> get datoscoloranteipsList => List.unmodifiable(_datoscoloranteipsList);

  DatosProviderPrefIPS() {
    _initDatabase();
  }

   Future<void> _initDatabase() async {
    _db = await openDatabase(
      p.join(await getDatabasesPath(), 'datosIPS.db'),      
      version: 1,
      onCreate: (db, version) => createTable(db),
    );
    await _loadData();
  }

   Future<void> createTable(Database db) async {
     
        await db.execute('''
        CREATE TABLE $tableDatosPROCEIPS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hasErrors INTEGER NOT NULL,
        hasSend INTEGER NOT NULL,
        idregistro INTEGER NOT NULL,
        Hora TEXT NOT NULL,
        PAprod TEXT NOT NULL,
        TempTolvaSec TEXT NOT NULL,
        TempProd REAL NOT NULL,
        Tciclo REAL NOT NULL,
        Tenfri REAL NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE $tableDatosPESOSIPS (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          hasErrors INTEGER NOT NULL,
          hasSend INTEGER NOT NULL,
          idregistro INTEGER NOT NULL,
          Hora TEXT NOT NULL,
          PA TEXT NOT NULL,
          PesoTara REAL NOT NULL,
          PesoNeto REAL NOT NULL,
          PesoTotal REAL NOT NULL
          )
        ''');
        await db.execute('''
        CREATE TABLE $tableDatosMPIPS (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
        hasErrors INTEGER NOT NULL,
        hasSend INTEGER NOT NULL,
        idregistro INTEGER NOT NULL,
        MateriPrima TEXT NOT NULL,
        INTF TEXT NOT NULL,
        CantidadEmpaque TEXT NOT NULL,
        Identif TEXT NOT NULL,
        CantidadBolsones INTEGER NOT NULL,
        Dosificacion REAL NOT NULL,
        Humedad REAL NOT NULL,
        Conformidad INTEGER NOT NULL
          )
        ''');
        await db.execute('''
        CREATE TABLE $tableDatosDEFIPS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hasErrors INTEGER NOT NULL,
        hasSend INTEGER NOT NULL,
        idregistro INTEGER NOT NULL,
        Hora TEXT NOT NULL,
        Defectos TEXT NOT NULL,
        Criticidad TEXT NOT NULL,
        CSeccionDefecto TEXT NOT NULL,
        DefectosEncontrados INTEGER NOT NULL,
        Fase TEXT NOT NULL,
        Palet INTEGER NOT NULL,
        Empaque INTEGER NOT NULL,
        Embalado INTEGER NOT NULL,
        Etiquetado INTEGER NOT NULL,
        Inocuidad INTEGER NOT NULL,
        CantidadProductoRetenido REAL NOT NULL,
        CantidadProductoCorregido REAL NOT NULL,
        Observaciones TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableDatosTEMPIPS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hasErrors INTEGER NOT NULL,
        hasSend INTEGER NOT NULL,
        idregistro INTEGER NOT NULL,
        Hora TEXT NOT NULL,
        Fase TEXT NOT NULL,
        Cavidades TEXT NOT NULL,
        Tcuerpo TEXT NOT NULL,
        Tcuello TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableDatosColoranteIPS (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        hasErrors INTEGER NOT NULL,
        hasSend INTEGER NOT NULL,
        idregistro INTEGER NOT NULL,
        Colorante TEXT NOT NULL,
        Codigo TEXT NOT NULL,
        KL TEXT NOT NULL,
        BP TEXT NOT NULL,
        Dosificacion REAL NOT NULL,
        CantidadBolsone INTEGER NOT NULL
      )
    ''');
  } 

  Future<void> _loadData() async { 

    final proceMaps = await _db.query(tableDatosPROCEIPS);
    _datosproceipsList = proceMaps.map((map) => DatosPROCEIPS.fromMap(map)).toList();

    final pesosMaps = await _db.query(tableDatosPESOSIPS);
    _datospesosipsList = pesosMaps.map((map) => DatosPESOSIPS.fromMap(map)).toList();

     final MPmaps = await _db.query(tableDatosMPIPS);
    _datosmpipsList = MPmaps.map((map) => DatosMPIPS.fromMap(map)).toList();

    final defmaps = await _db.query(tableDatosDEFIPS);
    _datosdefipsList = defmaps.map((map) => DatosDEFIPS.fromMap(map)).toList();

    final tempmaps = await _db.query(tableDatosTEMPIPS);
    _datostempipsList = tempmaps.map((map) => DatosTEMPIPS.fromMap(map)).toList();

      final maps = await _db.query(tableDatosColoranteIPS);
  _datoscoloranteipsList = maps.map((map) => DatosColoranteIPS.fromMap(map)).toList();

  // Si no hay datos, agrega uno automáticamente
  if (_datoscoloranteipsList.isEmpty) {     
    
      final nuevo = DatosColoranteIPS(
        hasErrors: true,
        hasSend: false,
        idregistro: 0,
        Colorante: 'Microbatch azul',
        Codigo: '',
        KL: '',
        BP: '',
        Dosificacion: 0,
        CantidadBolsone: 1,
      );

      await addDatosColoranteIPS(nuevo); // Asumiendo que esta función guarda y notifica
    
  }

  notifyListeners();
  }
  
   Future<void> addDatosColoranteIPS(DatosColoranteIPS nuevoDato) async {
    final id = await _db.insert(tableDatosColoranteIPS, nuevoDato.toMap());
    _datoscoloranteipsList.add(nuevoDato.copyWith(id: id));
    notifyListeners();
  }

  Future<void> addDatosMPIPS(DatosMPIPS nuevoDato) async {
    final id = await _db.insert(tableDatosMPIPS, nuevoDato.toMap());
    _datosmpipsList.add(nuevoDato.copyWith(id: id));
    notifyListeners();
  }

  Future<void> addProceIPS(DatosPROCEIPS nuevo) async {
    final id = await _db.insert(tableDatosPROCEIPS, nuevo.toMap());
    _datosproceipsList.add(nuevo.copyWith(id: id));
    notifyListeners();
  }

  Future<void> addPesosIPS(DatosPESOSIPS nuevo) async {
    final id = await _db.insert(tableDatosPESOSIPS, nuevo.toMap());
    _datospesosipsList.add(nuevo.copyWith(id: id));
    notifyListeners();
  }
  Future<void> addDatosDEFIPS(DatosDEFIPS nuevoDato) async {
    final id = await _db.insert(tableDatosDEFIPS, nuevoDato.toMap());
    _datosdefipsList.add(nuevoDato.copyWith(id: id));
    notifyListeners();
  }

  Future<void> addDatosTEMPIPS(DatosTEMPIPS nuevoDato) async {
    final id = await _db.insert(tableDatosTEMPIPS, nuevoDato.toMap());
    _datostempipsList.add(nuevoDato.copyWith(id: id));
    notifyListeners();
  }

  Future<void> updateDatosColoranteIPS(int id, DatosColoranteIPS updatedDato) async {
    final index = _datoscoloranteipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      await _db.update(
        tableDatosColoranteIPS,
        updatedDato.copyWith(id: id).toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      _datoscoloranteipsList[index] = updatedDato.copyWith(id: id);
      notifyListeners();
    }
  }  

  Future<void> updateDatosTEMPIPS(int id, DatosTEMPIPS updatedDato) async {
    final index = _datostempipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      await _db.update(
        tableDatosTEMPIPS,
        updatedDato.copyWith(id: id).toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      _datostempipsList[index] = updatedDato.copyWith(id: id);
      notifyListeners();
    }
  }

  Future<void> updateDatosMPIPS(int id, DatosMPIPS updatedDato) async {
    final index = _datosmpipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      await _db.update(
        tableDatosMPIPS,
        updatedDato.copyWith(id: id).toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosmpipsList[index] = updatedDato.copyWith(id: id);
      notifyListeners();
    }
  }

  Future<void> updateProcesos(int id, DatosPROCEIPS updatedDato) async {
    final index = _datosproceipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      await _db.update(
        tableDatosPROCEIPS,
        updatedDato.copyWith(id: id).toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosproceipsList[index] = updatedDato.copyWith(id: id);
      notifyListeners();
    }
  }

  Future<void> updateDatosDEFIPS(int id, DatosDEFIPS updatedDato) async {
    final index = _datosdefipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      await _db.update(
        tableDatosDEFIPS,
        updatedDato.copyWith(id: id).toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosdefipsList[index] = updatedDato.copyWith(id: id);
      notifyListeners();
    }
  }

  Future<void> updatePESO(int id, DatosPESOSIPS updatedDato) async {
    final index = _datospesosipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      await _db.update(
        tableDatosPESOSIPS,
        updatedDato.copyWith(id: id).toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
      _datospesosipsList[index] = updatedDato.copyWith(id: id);
      notifyListeners();
    }
  }

  Future<void> removeDatosMPIPS(BuildContext context, int id) async {
    final index = _datosmpipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      final deletedData = _datosmpipsList[index];
      await _db.delete(
        tableDatosMPIPS,
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosmpipsList.removeAt(index);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registro eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () async {
              final newId = await _db.insert(tableDatosMPIPS, deletedData.toMap());
              _datosmpipsList.insert(index, deletedData.copyWith(id: newId));
              notifyListeners();
            },
          ),
        ),
      );
    }
  }

  Future<void> removeProceso(BuildContext context, int id) async {
    final index = _datosproceipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      final deletedData = _datosproceipsList[index];
      await _db.delete(
        tableDatosPROCEIPS,
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosproceipsList.removeAt(index);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registro eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () async {
              final newId = await _db.insert(tableDatosPROCEIPS, deletedData.toMap());
              _datosproceipsList.insert(index, deletedData.copyWith(id: newId));
              notifyListeners();
            },
          ),
        ),
      );
    }
  }
  Future<void> removeDatosDEFIPS(BuildContext context, int id) async {
    final index = _datosdefipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      final deletedData = _datosdefipsList[index];
      await _db.delete(
        tableDatosDEFIPS,
        where: 'id = ?',
        whereArgs: [id],
      );
      _datosdefipsList.removeAt(index);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registro eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () async {
              final newId = await _db.insert(tableDatosDEFIPS, deletedData.toMap());
              _datosdefipsList.insert(index, deletedData.copyWith(id: newId));
              notifyListeners();
            },
          ),
        ),
      );
    }
  }
  Future<void> removePeso(BuildContext context, int id) async {
    final index = _datospesosipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      final deletedData = _datospesosipsList[index];
      await _db.delete(
        tableDatosPESOSIPS,
        where: 'id = ?',
        whereArgs: [id],
      );
      _datospesosipsList.removeAt(index);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registro eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () async {
              final newId =
                  await _db.insert(tableDatosPESOSIPS, deletedData.toMap());
              _datospesosipsList.insert(index, deletedData.copyWith(id: newId));
              notifyListeners();
            },
          ),
        ),
      );
    }
  }  

  Future<void> removeDatosTEMPIPS(BuildContext context, int id) async {
    final index = _datostempipsList.indexWhere((d) => d.id == id);
    if (index != -1) {
      final deletedData = _datostempipsList[index];
      await _db.delete(
        tableDatosTEMPIPS,
        where: 'id = ?',
        whereArgs: [id],
      );
      _datostempipsList.removeAt(index);
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Registro eliminado'),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () async {
              final newId = await _db.insert(tableDatosTEMPIPS, deletedData.toMap());
              _datostempipsList.insert(index, deletedData.copyWith(id: newId));
              notifyListeners();
            },
          ),
        ),
      );
    }
  }

  Future<void> removeAllPesos() async {
  await _db.delete(tableDatosPESOSIPS);
  _datospesosipsList.clear();
  notifyListeners();
}

Future<void> removeAllProcesos(BuildContext context) async {
    final confirmation = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmación'),
        content: const Text(
            '¿Está seguro de que desea eliminar todos los registros? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmation == true) {
      await _db.delete(
          tableDatosPROCEIPS);
      _datosproceipsList.clear();
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Todos los registros han sido eliminados.')),
      );
    }
  }

Future<void> finishProcess() async {
  await _db.delete(tableDatosPESOSIPS);
  await _db.execute("DELETE FROM sqlite_sequence WHERE name='$tableDatosPESOSIPS'");
  _datospesosipsList.clear();
  await _db.delete(tableDatosMPIPS);
  await _db.execute("DELETE FROM sqlite_sequence WHERE name='$tableDatosMPIPS'");
  _datostempipsList.clear();
  await _db.delete(tableDatosDEFIPS);
  await _db.execute("DELETE FROM sqlite_sequence WHERE name='$tableDatosDEFIPS'");
  _datosdefipsList.clear();
  await _db.delete(tableDatosPROCEIPS);
  await _db.execute("DELETE FROM sqlite_sequence WHERE name='$tableDatosPROCEIPS'");
  _datosproceipsList.clear();
  await _db.delete(tableDatosTEMPIPS);
  await _db.execute("DELETE FROM sqlite_sequence WHERE name='$tableDatosTEMPIPS'");
  _datostempipsList.clear();
  // Restablecer los valores predeterminados en la tabla Colorante
  await _db.update(
    tableDatosColoranteIPS,
    {
      'hasErrors': true,
      'hasSend': false,
      'idregistro': 0,
      'Colorante': 'Microbatch azul',
      'Codigo': '',
      'KL': '',
      'BP': '',
      'Dosificacion': 0,
      'CantidadBolsone': 1,
    },
    where: 'id = ?', // Ajusta el ID si es diferente
    whereArgs: [1], // Usar el ID correcto
  );

  // Limpiar la lista en memoria
  _datoscoloranteipsList[0] = DatosColoranteIPS(
    hasErrors: true,
    hasSend: false,
    idregistro: 0,
    Colorante: 'Microbatch azul',
    Codigo: '',
    KL: '',
    BP: '',
    Dosificacion: 0,
    CantidadBolsone: 1,
  );

  notifyListeners();
}

Future<bool> enviarDatosAPIDatosColoranteIPS(int id) async {
    final url = Uri.parse("${Config.baseUrl}/Colorante");

    // Buscar el dato actualizado en SQLite
    final index = _datoscoloranteipsList.indexWhere((d) => d.id == id);
    if (index == -1) {
      print("❌ Error: No se encontró el dato con ID $id en SQLite");
      return false;
    }

    final DatosColoranteIPS dato = _datoscoloranteipsList[index];

    // Convertir a JSON sin 'id' y 'hasErrors'
    final Map<String, dynamic> datosJson = {
    "ID_regis": dato.idregistro,
      "Colorante": dato.Colorante,
      "Codigo": dato.Codigo,
      "KL": dato.KL,
      "BP": dato.BP,
      "Dosificacion": dato.Dosificacion,
      "CantidadBolsone": dato.CantidadBolsone
    };

    print("📤 Enviando datos a la API: $datosJson");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(datosJson),
      );

      print(
          "📥 Respuesta del servidor: ${response.statusCode} - ${response.body}");

    

      if (response.statusCode == 201) {
        return true;
      } else {
        print("❌ Error al enviar datos. Código: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("❌ Error de conexión: $e");
      return false;
    }
  }

Future<bool> enviarDatosAPIDatosMPIPS(int id) async {
    final url = Uri.parse("${Config.baseUrl}/MPips");

    // Buscar el dato actualizado en SQLite
    final index = _datosmpipsList.indexWhere((d) => d.id == id);
    if (index == -1) {     
      return false;
    }

    final DatosMPIPS dato = _datosmpipsList[index];

    // Convertir a JSON sin 'id' y 'hasErrors'
   final Map<String, dynamic> datosJson = {
      "MateriaPrima": dato.MateriPrima,
      "INTF": dato.INTF,
      "CantidadEmpaque": dato.CantidadEmpaque,
      "Identif": dato.Identif,
      "CantidadBolsones": dato.CantidadBolsones,
      "Dosificacion": dato.Dosificacion,
      "Humedad": dato.Humedad,
      "Conformidad": dato.Conformidad,
      "ID_regis": dato.idregistro      
    };

    try {
      final response = await http.post(
        url,
         headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",  // Asegura que reciba JSON en vez de HTML
        },
        body: jsonEncode(datosJson),
      );


      if (response.statusCode == 201) {
        return true;
      } else {
     
        return false;
      }
    } catch (e) {
    
      return false;
    }
  }


Future<bool> enviarDatosAPIPeso(int id) async {
    final url = Uri.parse("${Config.baseUrl}/pesosips");

    // Buscar el dato actualizado en SQLite
    final index = _datospesosipsList.indexWhere((d) => d.id == id);
    if (index == -1) {
   
      return false;
    }

    final DatosPESOSIPS dato = _datospesosipsList[index];

    // Convertir a JSON sin 'id' y 'hasErrors'
    final Map<String, dynamic> datosJson = {
      "Hora": dato.Hora,
      "PA": dato.PA,
      "PesoTara": dato.PesoTara,
      "PesoNeto": dato.PesoNeto,
      "PesoTotal": dato.PesoTotal,
      "ID_regis": dato.idregistro
    };

   

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json",
          "Accept": "application/json",},
        body: jsonEncode(datosJson),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
       
        return false;
      }
    } catch (e) {
  
      return false;
    }
  }

  Future<bool> enviarDatosAPIDatosDEFIPS(int id) async {
    final url = Uri.parse("${Config.baseUrl}/defectosips");

    // Buscar el dato actualizado en SQLite
    final index = _datosdefipsList.indexWhere((d) => d.id == id);
    if (index == -1) {
     
      return false;
    }

    final DatosDEFIPS dato = _datosdefipsList[index];

    // Convertir a JSON sin 'id' y 'hasErrors'
    final Map<String, dynamic> datosJson = {
      "Hora": dato.Hora,
      "Defectos": dato.Defectos,
      "Criticidad": dato.Criticidad,
      "CSeccionDefecto": dato.CSeccionDefecto,
      "DefectosEncontrados": dato.DefectosEncontrados,
      "Fase": dato.Fase,
      "Palet": dato.Palet,
      "Empaque": dato.Empaque,
      "Embalado": dato.Embalado,
      "Etiquetado": dato.Etiquetado,
      "Inocuidad": dato.Inocuidad,
      "CantidadProductoRetenido": dato.CantidadProductoRetenido,
      "CantidadProductoCorregido": dato.CantidadProductoCorregido,
      "Observaciones": dato.Observaciones,
      "ID_regis": dato.idregistro
    };

    

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json",
          "Accept": "application/json",},
        body: jsonEncode(datosJson),
      );

      

      if (response.statusCode == 201) {
        return true;
      } else {
       
        return false;
      }
    } catch (e) {
     
      return false;
    }
  }

  Future<bool> enviarDatosAPIDatosPROCEIPS(int id) async {
    final url = Uri.parse("${Config.baseUrl}/procesIPS");

    // Buscar el dato actualizado en SQLite
    final index = _datosproceipsList.indexWhere((d) => d.id == id);
    if (index == -1) {
      
      return false;
    }

    final DatosPROCEIPS dato = _datosproceipsList[index];

    // Convertir a JSON sin 'id' y 'hasErrors'
    final Map<String, dynamic> datosJson = {
      "Hora": dato.Hora,
      "PAprod": dato.PAprod,
      "TempTolvaSec": dato.TempTolvaSec,
      "TempProd": dato.TempProd,
      "Tciclo": dato.Tciclo,
      "Tenfri": dato.Tenfri,
      "ID_regis": dato.idregistro      
    };

    

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json",
          "Accept": "application/json",},
        body: jsonEncode(datosJson),
      );

      

      if (response.statusCode == 201) {
        return true;
      } else {
        
        return false;
      }
    } catch (e) {
     
      return false;
    }
  }
Future<bool> enviarDatosAPIDatosTEMPIPS(int id) async {
    final url = Uri.parse("${Config.baseUrl}/tempIPS");

    // Buscar el dato actualizado en SQLite
    final index = _datostempipsList.indexWhere((d) => d.id == id);
    if (index == -1) {
     
      return false;
    }

    final DatosTEMPIPS dato = _datostempipsList[index];

    // Convertir a JSON sin 'id' y 'hasErrors'
    final Map<String, dynamic> datosJson = {
    "ID_regis": dato.idregistro,
      "Hora": dato.Hora,
      "Fase": dato.Fase,
      "Cavidades": dato.Cavidades,
      "Tcuerpo": dato.Tcuerpo,
      "Tcuello": dato.Tcuello
    };

    

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json",
          "Accept": "application/json",},
        body: jsonEncode(datosJson),
      );

     

      if (response.statusCode == 201) {
        return true;
      } else {
        
        return false;
      }
    } catch (e) {
      
      return false;
    }
  }
}