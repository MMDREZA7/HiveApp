import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_practice/Views/user_info_model.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final String USER_INFO_HIVE_BOX = 'userIfon';

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const textstyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    final buttonstyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        Colors.cyan[900],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.cyan[900],
        title: const Text(
          'Hive',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 33, 92, 100),
                      ),
                    ),
                    const SizedBox(height: 100),
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _fullNameController.clear();
                            print('FullName Data Cleared!');
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        hintText: 'Full Name',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _ageController.clear();
                            print('Age Data Cleared!');
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        hintText: 'Age',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _cityController.clear();
                            print('City Data Cleared!');
                          },
                          icon: const Icon(Icons.clear),
                        ),
                        hintText: 'City',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: _saveData,
                          style: buttonstyle,
                          child: const Text(
                            'Save Data',
                            style: textstyle,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        TextButton(
                          onPressed: _loadData,
                          style: buttonstyle,
                          child: const Text(
                            'Load from cache',
                            style: textstyle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // end build
  void _saveData() async {
    print('Data Saved!');
    String fullName = _fullNameController.text;
    int age = int.parse(_ageController.text);
    String city = _cityController.text;

    var user = UserInfo(fullname: fullName, age: age, city: city);
    var box = await Hive.openBox(USER_INFO_HIVE_BOX);
    box.put('user', user);
    box.close();

    setState(() {});
  }

  // Seve Data Void
  // void _saveData() async {
  //   print('Data Saved!');
  //   String fullName = _fullNameController.text;
  //   int age = int.parse(_ageController.text);
  //   String city = _cityController.text;

  //   var box = await Hive.openBox(USER_INFO_HIVE_BOX);
  //   box.put('fullname', fullName);
  //   box.put('age', age);
  //   box.put('city', city);
  //   box.close();

  //   setState(() {});
  // }

  void _loadData() async {
    print('Data Loaded!');

    var box = await Hive.openBox(USER_INFO_HIVE_BOX);
    UserInfo user = box.get('user');
    _fullNameController.text = user.fullname;
    _ageController.text = user.age.toString();
    _cityController.text = user.city;
    box.close();

    setState(() {});
  }

  //Load Data void
  // void _loadData() async {
  //   print('Data Loaded!');

  //   var box = await Hive.openBox(USER_INFO_HIVE_BOX);
  //   _fullNameController.text = box.get('fullname');
  //   _ageController.text = "${box.get('age')}";
  //   _cityController.text = box.get('city');
  //   box.close();

  //   setState(() {});
  // }
}
