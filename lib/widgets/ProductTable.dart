import 'package:flutter/material.dart';

class ProductTable extends StatefulWidget {
  const ProductTable({Key? key});

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  static const int numItems = 20;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  List<ProductData> _productData = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _addProductData(ProductData(
                  name: 'New Product',
                  price: 0.0,
                  description: 'Sample Description',
                  category: '',
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
              /*DataColumn(
                label: Text('Image'),
              ),*/
              DataColumn(

                label: Text('Price'),
              ),
              DataColumn(
                label: Text('Description'),
              ),
              DataColumn(
                label: Text('Category'),
              ),
              DataColumn(
                label: Text('Discount'),
              ),
              DataColumn(
                label: Text('Reviews'),
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
    rows.addAll(_productData.map((data) {
      final index = _productData.indexOf(data);
      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            // All rows will have the same selected color.
            if (states.contains(MaterialState.selected)) {
              return Theme.of(context).colorScheme.primary.withOpacity(0.08);
            }

            if (index.isEven) {
              return Colors.grey.withOpacity(0.3);
            }
            return null;
          },
        ),
        cells: [
          DataCell(Text(data.name)),
          DataCell(Text('\$${data.price.toStringAsFixed(2)}')),
          DataCell(Text(data.description)),
          DataCell(Text(data.category)),
          DataCell(Text(
            data.discount == 0.0
                ? 'No discount'
                : 'Discount: ${data.discount.toStringAsFixed(2)}',
          )),
          DataCell(Text(data.reviews ?? '')),
          DataCell(Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editProductData(index);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteProductData(index);
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

  void _addProductData(ProductData productData) {
    setState(() {
      _productData.add(productData);
    });
  }

  void _editProductData(int index) {
    //body
  }

  void _deleteProductData(int index) {
    setState(() {
      _productData.removeAt(index);
    });
  }

  void _deleteSelected() {
    for (int i = _productData.length - 1; i >= 0; i--) {
      if (selected[i]) {
        _productData.removeAt(i);
      }
    }

    selected = List<bool>.generate(_productData.length, (int index) => false);
  }
}

class ProductData {
  String name;
  double price;
  String description;
  String category;
  double discount;
  String? reviews;

  ProductData({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    this.discount = 0.0,
    this.reviews,
  });
}
