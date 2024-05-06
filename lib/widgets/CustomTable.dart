import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({Key? key});

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  List<UserData> _userData = []; // List to store user data

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align buttons to the start of the row
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addUserData(UserData(
                  name: 'New User',
                  phoneNumber: '1234567890',
                  address: 'Sample Address',
                  email: 'example@example.com',
                  gender: 'Male',
                  birthday: '2000-01-01',
                ));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteSelected();
              },
            ),
          ],
        ),
        SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Name'),
              ),
              DataColumn(
                label: Text('Phone Number'),
              ),
              DataColumn(
                label: Text('Address'),
              ),
              DataColumn(
                label: Text('Email'),
              ),
              DataColumn(
                label: Text('Gender'),
              ),
              DataColumn(
                label: Text('Birthday'),
              ),
              DataColumn(
                label: Text('Actions'),
              ),
            ],
            rows: _buildRows(),
          ),
        ),
      ],
    );
  }

  List<DataRow> _buildRows() {
    List<DataRow> rows = [];
    rows.addAll(_userData.map((data) {
      final index = _userData.indexOf(data);
      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            // All rows will have the same selected color.
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
            }
            // Even rows will have a grey color.
            if (index.isEven) {
              return Colors.grey.withOpacity(0.3);
            }
            return null;
          },
        ),
        cells: [
          DataCell(Text(data.name)),
          DataCell(Text(data.phoneNumber)),
          DataCell(Text(data.address)),
          DataCell(Text(data.email)),
          DataCell(Text(data.gender)),
          DataCell(Text(data.birthday)),
          DataCell(Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editUserData(index);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteUserData(index);
                },
              ),
            ],
          )),
        ],
        selected: selected[index],
        onSelectChanged: (bool? value) {
          setState(() {
            selected[index] = value!;
          });
        },
      );
    }));
    return rows;
  }

  void _addUserData(UserData userData) {
    setState(() {
      _userData.add(userData);
    });
  }

  void _editUserData(int index) {
    // You can implement editing logic here.
  }

  void _deleteUserData(int index) {
    setState(() {
      _userData.removeAt(index);
    });
  }

  void _deleteSelected() {
    for (int i = _userData.length - 1; i >= 0; i--) {
      if (selected[i]) {
        _userData.removeAt(i);
      }
    }
    // Reset all selections after deleting
    selected = List<bool>.generate(_userData.length, (int index) => false);
  }
}

class UserData {
  String name;
  String phoneNumber;
  String address;
  String email;
  String gender;
  String birthday;

  UserData({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.gender,
    required this.birthday,
  });
}
