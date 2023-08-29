import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tarefas/models/tarefas_model.dart';
import 'package:tarefas/helpers/database_helpers.dart';

class MockDatabase extends Mock implements Database {}

void main() {
  group('TESTES DATABASE INSERT | ', () {
    late DatabaseHelper databaseHelper;
    late MockDatabase mockDatabase;

    setUp(() {
      databaseHelper = DatabaseHelper();
      mockDatabase = MockDatabase();
    });

    //Teste para o método de inserção
    test('INSERIR TAREFA', () async {
      final tarefa =
          Tarefas(id: 1, nomeTarefa: 'Tarefa de teste', estado: true);
      final table = databaseHelper.tarefaTable;
      when(mockDatabase.insert(table, tarefa.toMap(excludeId: true)))
          .thenAnswer((_) async => 1);
      final result = await databaseHelper.insertTarefa(tarefa);

      expect(result, 1);
    });
  });
}
