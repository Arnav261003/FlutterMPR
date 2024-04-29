import 'package:flutter/material.dart';
import 'main.dart';

class AdminPage extends StatefulWidget {
  final List<Product>? customerProducts; // Making customerProducts optional

  AdminPage({this.customerProducts});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _showAddProductDialog(
      BuildContext context, List<Product>? customerProducts) {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                double price = double.tryParse(priceController.text) ?? 0.0;
                String description = descriptionController.text;

                // Validate the input fields
                if (name.isNotEmpty && price > 0) {
                  // Add the new product to the customer products list if available
                  if (customerProducts != null) {
                    Product newProduct = Product(
                      name: name,
                      price: price,
                      description: description,
                    );
                    customerProducts.add(newProduct);
                  }

                  // Navigate to the LoginPage and pass the product details
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        productName: name,
                        productPrice: price.toString(),
                        description: description,
                      ),
                    ),
                  );
                } else {
                  // Show an error message if any field is empty or invalid
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter valid product details.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  final List<Product> selectedProducts = [
    Product(
      name: 'Headphones',
      price: 2300,
      description: 'High-quality headphones for immersive audio experience.',
    ),
    Product(
      name: 'Android Smartphone',
      price: 17900,
      description:
          'Powerful smartphone with advanced features and sleek design.',
    ),
    Product(
      name: 'Phone case',
      price: 1300,
      description: 'Protective case with stylish design for your smartphone.',
    ),
    Product(
      name: 'Adapter',
      price: 2000,
      description: 'Versatile adapter for connecting various devices.',
    ),
    Product(
      name: 'Mouse',
      price: 3900,
      description: 'Ergonomic mouse for precise and comfortable navigation.',
    ),
    Product(
      name: 'Gaming keyboard',
      price: 5600,
      description: 'Mechanical keyboard with customizable RGB lighting.',
    ),
    Product(
      name: 'Laptop Cover',
      price: 1700,
      description: 'Durable cover to keep your laptop safe during transport.',
    ),
    Product(
      name: 'Fitness Band',
      price: 8800,
      description:
          'Track your fitness goals with this stylish and reliable fitness band.',
    ),
    Product(
      name: 'Charger',
      price: 2900,
      description: 'Fast charger for quickly powering up your devices.',
    ),
    Product(
      name: 'Wireless Earbuds',
      price: 4500,
      description:
          'True wireless earbuds with crystal clear sound and comfortable fit.',
    ),
    Product(
      name: 'Smartwatch',
      price: 9900,
      description:
          'Stay connected and organized with this feature-rich smartwatch.',
    ),
    Product(
      name: 'Bluetooth Speaker',
      price: 6500,
      description: 'Portable speaker for enjoying music anywhere you go.',
    ),
    Product(
      name: 'USB-C Cable',
      price: 1000,
      description:
          'High-speed USB-C cable for fast data transfer and charging.',
    ),
    Product(
      name: 'External Hard Drive',
      price: 7900,
      description:
          'Expand your storage capacity with this reliable external hard drive.',
    ),
    Product(
      name: 'Wireless Mouse',
      price: 2500,
      description: 'Wireless mouse for enhanced productivity and comfort.',
    ),
    Product(
      name: 'Portable Power Bank',
      price: 3000,
      description: 'Compact power bank for charging your devices on the go.',
    ),
    Product(
      name: 'Smart Light Bulbs',
      price: 1500,
      description:
          'Energy-efficient smart bulbs for customizable lighting control.',
    ),
    Product(
      name: 'Travel Backpack',
      price: 5000,
      description:
          'Durable backpack designed for travel and outdoor adventures.',
    ),
    Product(
      name: 'Wireless Charging Pad',
      price: 2000,
      description:
          'Convenient wireless charging pad for Qi-compatible devices.',
    ),
  ];

  List<Product> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = selectedProducts;
  }

  void filterProducts(String query) {
    setState(() {
      filteredProducts = selectedProducts
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Page',
          style: TextStyle(
            color: Colors.white, // Text color of appbar
            shadows: [Shadow(color: Colors.white, blurRadius: 8)], // Text glow
          ),
        ),
        backgroundColor: Color(0xFFB100CD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Add product action
              _showAddProductDialog(context, widget.customerProducts);
            },
            icon: Icon(Icons.add), // Plus icon
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filterProducts,
              decoration: InputDecoration(
                hintText: 'Search by product name',
                hintStyle:
                    TextStyle(color: Colors.white), // Placeholder text color
                prefixIcon: Icon(
                  Icons.search,
                  color: Color(0xFFB100CD), // Icon color
                ),
                filled: true,
                fillColor: Color(0xFF343434), // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              style: TextStyle(color: Colors.white), // Text color
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                filteredProducts.length,
                (index) => ProductCard(product: filteredProducts[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Color.fromARGB(
          128, 239, 196, 246), // Lighter background color with opacity
      child: InkWell(
        onTap: () {
          // Handle product tap
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold, // Make product name bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.0),
              Text(
                '\Rs.${product.price.toString()}',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4.0),
              Text(
                product.description,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.black87), // Description text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.description,
  });
}
