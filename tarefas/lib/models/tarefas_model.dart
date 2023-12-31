import 'enums_model.dart';

class Tarefas {
  int? id;
  String? nomeTarefa;
  bool? estado;
  Prioridade? prioridade;
  List<String>? tags;
  String? nota;
  double? progrecao;
  PadraoRepeticao? padraoRepeticao;

  Tarefas({required int id, required String nomeTarefa, required bool estado}) {
    this.id = id;
    this.nomeTarefa = nomeTarefa;
    this.estado = estado;
  }

  Map<String, dynamic> toMap({bool excludeId = false}) {
    var map = <String, dynamic>{
      'nomeTarefa': nomeTarefa,
      'estado': estado,
    };

    if (!excludeId) {
      map['id'] = id;
    }
    return map;
  }

  Tarefas.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nomeTarefa = map['nomeTarefa'];
    estado = map['estado'] == 1;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Tarefa => (id: $id, nomeTarefa: $nomeTarefa, estado: $estado)';
  }
}
