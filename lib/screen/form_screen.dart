import 'package:flutter/material.dart';
import 'package:flutter_organizer/components/task.dart';
import 'package:flutter_organizer/data/task_dao.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }

  bool ratingValidator(String? value) {
    if (value != null && value.isEmpty) {
      if (int.parse(value) < 1 || int.parse(value) > 5) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            title: const Padding(
              padding: EdgeInsets.all(20),
              child: Text('Create or Update Task'),
            ),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 790,
                width: 395,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Please enter a task name';
                          }
                          return null;
                        },
                        controller: nameController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Task Name',
                            fillColor: Colors.white70,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        validator: (String? value) {
                          if (ratingValidator(value)) {
                            return 'Please enter a task rating';
                          }
                          return null;
                        },
                        controller: ratingController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Rating',
                            fillColor: Colors.white70,
                            filled: true),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Please enter an image URL for the task';
                          }
                          return null;
                        },
                        controller: imageController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.url,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Image URL',
                            fillColor: Colors.white70,
                            filled: true),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageController.text,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                                'assets/images/Nophoto-512.webp');
                          },
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await TaskDao().save(Task(
                              nameController.text,
                              imageController.text,
                              int.parse(ratingController.text),
                            ));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Creating Task...'),
                            ));
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Add Task')),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
