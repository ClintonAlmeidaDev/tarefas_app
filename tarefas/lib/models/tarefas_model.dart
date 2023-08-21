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

  Tarefas({this.id, this.nomeTarefa, this.estado = true, this.nota});
}
