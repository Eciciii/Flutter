import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Manajemen Tugas',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Manajemen Tugas'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat datang di Manajemen Tugas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskManagerHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text('Lihat Daftar Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskManagerHomePage extends StatefulWidget {
  @override
  _TaskManagerHomePageState createState() => _TaskManagerHomePageState();
}

class _TaskManagerHomePageState extends State<TaskManagerHomePage> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
  }

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void updateTask(Task task) {
    setState(() {
      int index = tasks.indexWhere((element) => element.title == task.title);
      if (index != -1) {
        tasks[index] = task;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat datang di Beranda Manajemen Tugas!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskListPage(tasks: tasks, updateTask: updateTask)),
                );
              },
              child: Text('Lihat Daftar Tugas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateTaskPage(addTask: addTask)),
                );
              },
              child: Text('Buat Tugas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReminderSettingPage(tasks: tasks)),
                );
              },
              child: Text('Atur Pengingat'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrackTaskProgressPage(tasks: tasks)),
                );
              },
              child: Text('Lacak Kemajuan Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateTaskPage extends StatefulWidget {
  final Function(Task) addTask;

  const CreateTaskPage({Key? key, required this.addTask}) : super(key: key);

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Halaman Buat Tugas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('Batas Waktu: '),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveTask();
              },
              child: Text('Simpan Tugas'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _saveTask() {
    String title = _titleController.text;
    String description = _descriptionController.text;
    DateTime deadline = _selectedDate;

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon isi semua kolom.'),
        ),
      );
      return;
    }

    Task newTask = Task(title: title, description: description, deadline: deadline);
    widget.addTask(newTask);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tugas berhasil disimpan!'),
      ),
    );

    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedDate = DateTime.now();
    });
  }
}

class TaskListPage extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) updateTask;

  TaskListPage({required this.tasks, required this.updateTask});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas'),
      ),
      body: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.tasks[index].title),
            subtitle: Text(widget.tasks[index].description),
            trailing: Text('Batas Waktu: ${widget.tasks[index].deadline.toString().substring(0, 10)}'),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditTaskPage(task: widget.tasks[index])),
              );
              if (result != null) {
                widget.updateTask(result);
                setState(() {});
              }
            },
          );
        },
      ),
    );
  }
}

class EditTaskPage extends StatefulWidget {
  final Task task;

  EditTaskPage({required this.task});

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _selectedDate = widget.task.deadline;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Halaman Edit Tugas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Judul'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi'),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text('Batas Waktu: '),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateTask();
              },
              child: Text('Perbarui Tugas'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _updateTask() {
    String title = _titleController.text;
    String description = _descriptionController.text;
    DateTime deadline = _selectedDate;

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mohon isi semua kolom.'),
        ),
      );
      return;
    }

    Task updatedTask = Task(title: title, description: description, deadline: deadline);
    Navigator.of(context).pop(updatedTask);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tugas berhasil diperbarui!'),
      ),
    );

    Navigator.pop(context, updatedTask);
  }
}

class TrackTaskProgressPage extends StatelessWidget {
  final List<Task> tasks;

  const TrackTaskProgressPage({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lacak Kemajuan Tugas'),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'Tidak ada tugas yang ditambahkan.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Text(tasks[index].description),
                  trailing: Text('Batas Waktu: ${tasks[index].deadline.toString().substring(0, 10)}'),
                );
              },
            ),
    );
  }
}

class ReminderSettingPage extends StatelessWidget {
  final List<Task> tasks;

  const ReminderSettingPage({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Atur Pengingat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Atur Pengingat',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReminderSettingForm(tasks: tasks)),
                );
              },
              child: Text('Atur Pengingat'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReminderSettingForm extends StatefulWidget {
  final List<Task> tasks;

  ReminderSettingForm({Key? key, required this.tasks}) : super(key: key);

  @override
  _ReminderSettingFormState createState() => _ReminderSettingFormState();
}

class _ReminderSettingFormState extends State<ReminderSettingForm> {
  bool _dailyReminder = false;
  bool _weeklyReminder = false;
  bool _customReminder = false;
  List<Task> _selectedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan Pengingat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Pilih jenis pengingat:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('Pengingat Harian'),
              value: _dailyReminder,
              onChanged: (bool? value) {
                setState(() {
                  _dailyReminder = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Pengingat Mingguan'),
              value: _weeklyReminder,
              onChanged: (bool? value) {
                setState(() {
                  _weeklyReminder = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Pengingat Kustom'),
              value: _customReminder,
              onChanged: (bool? value) {
                setState(() {
                  _customReminder = value!;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              'Pilih tugas yang ingin diingatkan:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.tasks.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(widget.tasks[index].title),
                    value: _selectedTasks.contains(widget.tasks[index]),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          _selectedTasks.add(widget.tasks[index]);
                        } else {
                          _selectedTasks.remove(widget.tasks[index]);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveReminderSettings();
              },
              child: Text('Simpan Pengingat'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveReminderSettings() {
    String message = 'Pengaturan pengingat berhasil disimpan:';
    if (_dailyReminder) {
      message += '\nPengingat Harian';
    }
    if (_weeklyReminder) {
      message += '\nPengingat Mingguan';
    }
    if (_customReminder) {
      message += '\nPengingat Kustom';
    }
    if (_selectedTasks.isNotEmpty) {
      message += '\nTugas yang diingatkan:';
      for (Task task in _selectedTasks) {
        message += '\n- ${task.title}';
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class Task {
  final String title;
  final String description;
  final DateTime deadline;

  Task({required this.title, required this.description, required this.deadline});
}
