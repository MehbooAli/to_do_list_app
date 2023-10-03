import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Todo App"),
        ),
        body: const Column(
          children: [
            _AlertDilog(),
          ],
        ));
  }
}

// Show dilog for take input
class _AlertDilog extends StatefulWidget {
  const _AlertDilog({Key? key}) : super(key: key);

  @override
  State<_AlertDilog> createState() => __AlertDilogState();
}

class __AlertDilogState extends State<_AlertDilog> {
  TextEditingController textEditingController = TextEditingController();
  String storeValue = "";
  List<TaskItem> items = [];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                final taskItem = items[index];
                return ListTile(
                  title: Text(taskItem.task),
                  trailing: SizedBox(
                    width: 140,
                    child: Row(children: [
                      Checkbox(
                        value: taskItem.isCompleted,
                        onChanged: (value) {
                          setState(() {
                            taskItem.isCompleted = value!;
                          });
                        },
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    ]),
                  ),
                );
              },
            ),
            Row(
              children: [
                FilledButton(
                    onPressed: () {
                      dilog();
                    },
                    child: Text("Add Task")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> dilog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: SizedBox(
            width: 200,
            child: TextFormField(
              controller: textEditingController,
              onFieldSubmitted: (value) {
                Navigator.pop(context);
                setState(() {
                  items.add(TaskItem(task: textEditingController.text));
                  textEditingController.clear(); // Clear the text field
                });
              },
              decoration: const InputDecoration(
                hintText: "write Task",
              ),
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  items.add(TaskItem(task: textEditingController.text));
                  textEditingController.clear(); // Clear the text field
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber[800])),
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

class TaskItem {
  TaskItem({required this.task, this.isCompleted = false});

  String task;
  bool isCompleted;
}
