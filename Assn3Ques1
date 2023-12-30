import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Design Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MaterialDesign(),
        '/first': (context) =>
            const firstRoute(data: 'Hello from Material Page!'),
      },
    );
  }
}

class firstRoute extends StatelessWidget {
  const firstRoute({Key? key, required this.data}) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    Map<String, Object> userData = {};
    userData =
        ModalRoute.of(context)?.settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation First Route'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(data),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Name:")),
                    SizedBox(
                      width: 65,
                    ),
                    Text("${userData["name"]}"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Email:")),
                    SizedBox(
                      width: 65,
                    ),
                    Text("${userData["email"]}"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("RollNo:")),
                    SizedBox(
                      width: 65,
                    ),
                    Text("${userData["rollNo"]}"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {}, child: const Text("PhoneNumber:")),
                    SizedBox(
                      width: 30,
                    ),
                    Text("${userData["phoneNumber"]}"),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Go back'),
                onPressed: () {
                  Navigator.pop(context, 'Hello from first page!!');
                  Toast.show("User ${userData["name"]} Logged out",
                      duration: Toast.lengthShort, gravity: Toast.bottom);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialDesign extends StatefulWidget {
  @override
  _MaterialDesignState createState() => _MaterialDesignState();
}

class _MaterialDesignState extends State<MaterialDesign> {
  final mycontroller1 = TextEditingController();
  final mycontroller2 = TextEditingController();
  final mycontroller3 = TextEditingController();
  final mycontroller4 = TextEditingController();

  @override
  void dispose() {
    mycontroller1.dispose();
    mycontroller2.dispose();
    mycontroller3.dispose();
    mycontroller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Material Design Demo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            AppBar(
              title: const Text('Enter Your Details'),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Text("Name: "),
                Expanded(
                  child: TextField(
                    controller: mycontroller1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Email: "),
                  Expanded(
                    child: TextField(
                      controller: mycontroller2,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Roll No: "),
                  Expanded(
                    child: TextField(
                      controller: mycontroller3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Roll No",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("Phone Number: "),
                  Expanded(
                    child: TextField(
                      controller: mycontroller4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Phone Number",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Show Details'),
                onPressed: () async {
                  Map<String, Object> userData = {
                    "name": mycontroller1.text.toString(),
                    "email": mycontroller2.text.toString(),
                    "rollNo": mycontroller3.text.toString(),
                    "phoneNumber": mycontroller4.text.toString()
                  };
                  await Navigator.pushNamed(context, '/first',
                      arguments: userData);
                  mycontroller1.clear();
                  mycontroller2.clear();
                  mycontroller3.clear();
                  mycontroller4.clear();
                },
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
