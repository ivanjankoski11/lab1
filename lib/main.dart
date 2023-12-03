import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Subject {
  Subject({required this.name});
  String name;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ivan Jankoski 201105',
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
  final List<Subject> _subjects = <Subject>[
    Subject(name: "Mobilni Informaciski sistemi"),
    Subject(name: "Voved vo naukata za podatocite"),
    Subject(name: "Programiranje na video igri")
  ];
  final TextEditingController _textFieldController = TextEditingController();

  void _addSubject(String name) {
    setState(() {
      _subjects.add(Subject(name: name));
    });
    _textFieldController.clear();
  }

  void _deleteSubject(Subject subject) {
    setState(() {
      _subjects.removeWhere((element) => element.name == subject.name);
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a subject'),
          content: TextField(
            controller: _textFieldController,
            decoration:
                const InputDecoration(hintText: 'Type your subject here'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addSubject(_textFieldController.text);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("201105"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _subjects.map((Subject subject) {
          return SubjectItem(subject: subject, removeSubject: _deleteSubject);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add Subject',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SubjectItem extends StatelessWidget {
  SubjectItem({required this.subject, required this.removeSubject})
      : super(key: ObjectKey(subject));

  final Subject subject;
  final void Function(Subject subject) removeSubject;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Row(children: <Widget>[
        Expanded(
          child: Text(subject.name),
        ),
        IconButton(
          onPressed: () {
            removeSubject(subject);
          },
          iconSize: 30,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          alignment: Alignment.centerRight,
        ),
      ]),
    );
  }
}
