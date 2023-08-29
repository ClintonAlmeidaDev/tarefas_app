import 'package:flutter/material.dart';

import 'helpers/database_helpers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseHelper db = DatabaseHelper();
  final _form = GlobalKey<FormState>();
  final _tarefaDescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tarefas",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
        child: SingleChildScrollView(
          // Adicionado SingleChildScrollView
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _form,
                child: TextFormField(
                  controller: _tarefaDescricao,
                  style: const TextStyle(fontSize: 22),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nome da Tarefa",
                    prefixIcon: Icon(Icons.event_available),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
