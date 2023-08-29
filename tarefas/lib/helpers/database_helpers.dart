import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarefas/models/tarefas_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  //Colunas da tabela
  String tarefaTable = 'tarefaTable';
  String colId = 'id';
  String colNomeTarefa = 'nomeTarefa';
  String colEstado = 'estado';

  //Construtor para criar instancia de classe
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      //Executa uma vez apenas
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  //Valida se a tabela já foi inicializada
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  //Inicializa a base de dados
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}tarefasTableBase.db';

    var tarefasTable =
        await openDatabase(path, version: 1, onCreate: _createDb);

    return tarefasTable;
  }

  //Cria tabela
  Future<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tarefaTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNomeTarefa TEXT, $colEstado BIT)');
    print("TABLE CRIADA");
  }

  //Funcao insert no banco
  Future<int> insertTarefa(Tarefas tarefas) async {
    Database db = await this.database;
    var resultado =
        await db.insert(tarefaTable, tarefas.toMap(excludeId: true));
    return resultado;
  }

  //Funcao update no banco de dados
  Future<int> updateContato(Tarefas tarefas) async {
    var db = await this.database;

    var resultado = await db.update(tarefaTable, tarefas.toMap(),
        where: '$colId = ?', whereArgs: [tarefas.id]);
    return resultado;
  }

  //Deleta um registro no banco
  Future<int> deletaTarefa(int id) async {
    var db = await this.database;

    int resultado =
        await db.delete(tarefaTable, where: '$colId = ?', whereArgs: [id]);

    return resultado;
  }

  //retorna um contato pelo id
  Future<Tarefas?> getTarefasPorId(int id) async {
    Database db = await this.database;
    List<Map> maps = await db.query(tarefaTable,
        columns: [colId, colNomeTarefa, colEstado],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Tarefas.fromMap(maps.first.cast());
    } else {
      return null;
    }
  }

  //Obtem o numero de objetos contato no banco de dados
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tarefaTable');

    int? resultado = Sqflite.firstIntValue(x);
    return resultado!;
  }

  //Retorna todos os contatos da base

  Future<List<Tarefas>> getTarefas() async {
    Database db = await this.database;
    var resultado = await db.query(tarefaTable);

    List<Tarefas> lista = resultado.isNotEmpty
        ? resultado.map((c) => Tarefas.fromMap(c)).toList()
        : [];
    return lista;
  }

  //Fechar banco de dados
  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
