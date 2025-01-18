import 'package:flutter/material.dart';

class WarehouseScreen extends StatefulWidget {
  const WarehouseScreen({super.key});

  @override
  _WarehouseScreenState createState() => _WarehouseScreenState();
}

class _WarehouseScreenState extends State<WarehouseScreen> {
  // Initial warehouse size (from 50 to 300 items)
  int warehouseSize = 50;
  int currentStock = 0;

  // List of available items that can be added to the warehouse
  List<WarehouseItem> availableItems = [
    WarehouseItem(name: "Item 1", quantity: 10),
    WarehouseItem(name: "Item 2", quantity: 5),
    WarehouseItem(name: "Item 3", quantity: 20),
    WarehouseItem(name: "Item 4", quantity: 30),
    WarehouseItem(name: "Item 5", quantity: 50),
  ];

  // List of finalized items in the warehouse
  List<WarehouseItem> warehouseItems = [];

  // Function to update warehouse size
  void updateWarehouseSize(int newSize) {
    setState(() {
      warehouseSize = newSize;
      currentStock = warehouseItems.fold(0, (sum, item) => sum + item.quantity);
    });
  }

  // Function to add item
  void addItemToWarehouse(WarehouseItem item) {
    if (currentStock + item.quantity <= warehouseSize) {
      // Check if already exists
      int index = warehouseItems.indexWhere((warehouseItem) => warehouseItem.name == item.name);

      if (index != -1) {
        // If exists increase its quantity
        setState(() {
          warehouseItems[index].quantity += item.quantity;
          currentStock += item.quantity;
        });
      } else {
        // add it to the warehouse
        setState(() {
          warehouseItems.add(WarehouseItem(name: item.name, quantity: item.quantity));
          currentStock += item.quantity;
        });
      }
    } else {
//alert
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Not Enough Space'),
            content: Text('There is not enough space in the warehouse to add this item.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  void removeItemFromWarehouse(WarehouseItem item) {
    setState(() {
      warehouseItems.remove(item);
      currentStock -= item.quantity;
      availableItems.add(item);
    });
  }

 
  void showWarehouseSizeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Warehouse Size'),
          content: Slider(
            min: 50,
            max: 300,
            value: warehouseSize.toDouble(),
            divisions: 5,
            label: warehouseSize.toString(),
            onChanged: (value) {
              setState(() {
                warehouseSize = value.toInt();
                currentStock = warehouseItems.fold(0, (sum, item) => sum + item.quantity);
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
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
        title: Text('Warehouse Inventory'),
        backgroundColor: Color.fromRGBO(61, 51, 13, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: showWarehouseSizeDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       
            Container(
              padding: EdgeInsets.all(15),
              color: Color.fromARGB(141, 250, 240, 230),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Warehouse Size: $warehouseSize items',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text('Current Stock: $currentStock', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Icon(Icons.store, color: Color.fromRGBO(61, 51, 13, 1)),
                ],
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Available Items to Add:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: availableItems.length,
                itemBuilder: (context, index) {
                  final item = availableItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      leading: Icon(Icons.shopping_cart),
                      trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          addItemToWarehouse(item);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            
            SizedBox(height: 20),
            Text(
              'Items in Warehouse:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: warehouseItems.length,
                itemBuilder: (context, index) {
                  final item = warehouseItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      leading: Icon(Icons.check_circle),
                      trailing: IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          removeItemFromWarehouse(item);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WarehouseItem {
  final String name;
  int quantity;

  WarehouseItem({
    required this.name,
    required this.quantity,
  });
}
