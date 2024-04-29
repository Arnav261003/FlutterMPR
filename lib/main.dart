import 'package:flutter/material.dart';
import 'admin_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electronic Store',
      theme: ThemeData(
        primaryColor: Color(0xFFB100CD), // Updated appbar color
        scaffoldBackgroundColor:
            Color.fromARGB(255, 27, 27, 27), // Background color
      ),
      home: LoginPage(
        productName: '',
        productPrice: '',
        description: '',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String description;
  const LoginPage({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.description,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedUserType = 'Customer'; // Default value

  void _login(BuildContext context) {
    // Validate login credentials
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Simulate login logic
      if (_selectedUserType == 'Customer') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerPage(
              productName: widget.productName,
              productPrice: widget.productPrice,
              description: widget.description,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter username and password.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TechCentral',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.0),
            Text(
              'Welcome to TechCentral',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(color: Colors.white, blurRadius: 1)],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              'Your one-stop destination for all tech needs',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                shadows: [Shadow(color: Colors.white, blurRadius: 1)],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            TextFormField(
              controller: _usernameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle:
                    TextStyle(color: Colors.white), // Placeholder text color
                filled: true,
                fillColor: Color(0xFF343434),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Border color
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              style: TextStyle(color: Colors.white),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:
                    TextStyle(color: Colors.white), // Placeholder text color
                filled: true,
                fillColor: Color(0xFF343434),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Border color
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              items: ['Customer', 'Admin']
                  .map((userType) => DropdownMenuItem(
                        value: userType,
                        child: Text(
                          userType,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedUserType = value!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF343434),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Border color
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownColor:
                  Color(0xFF343434), // Dropdown menu background color
            ),
            Container(
              margin: EdgeInsets.only(top: 24.0), // Add top margin
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.4, // Set width to 40% of the screen width
                    height: 50.0, // Set height
                    child: ElevatedButton(
                      onPressed: () => _login(context),
                      child: Text('Login'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Color(0xFFB100CD)
                                  .withOpacity(0.5); // Disabled color
                            }
                            return Color(0xFFB100CD); // Use the standard color
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(
                            5.0), // Elevation of the button
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 24.0), // Padding of the button
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(color: Colors.white), // Text color
                        ),
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Reduce tap target size
                        animationDuration:
                            Duration(milliseconds: 200), // Animation duration
                        shadowColor: MaterialStateProperty.all<Color>(
                          Colors.black.withOpacity(0.2), // Shadow color
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white, // Text color
                        ),
                        overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.white
                                  .withOpacity(0.2); // Hover color
                            }
                            return Color(
                                0xFFB100CD); // Defer to the widget's default.
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0), // Add space between the buttons
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.4, // Set width to 40% of the screen width
                    height: 50.0, // Set height
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Color(0xFFB100CD), // Sign Up button color
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 27, 27, 27)),
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                              color: Color(0xFFB100CD),
                              width: 2), // Border color
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 24.0), // Padding of the button
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _selectedUserType = 'Customer'; // Default value

  void _signUp(BuildContext context) {
    // Validate form fields
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isValidEmail(_emailController.text) &&
        _isValidPassword(_passwordController.text)) {
      // Simulate sign up logic
      if (_selectedUserType == 'Customer') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomerPage(
              productName: '',
              productPrice: '',
              description: '',
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid information.'),
        ),
      );
    }
  }

  bool _isValidEmail(String email) {
    // Basic email validation
    return true;
  }

  bool _isValidPassword(String password) {
    // Password validation: at least one number and one special character
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
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
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              items: ['Customer', 'Admin']
                  .map((userType) => DropdownMenuItem(
                        value: userType,
                        child: Text(
                          userType,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                _selectedUserType = value!;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFF343434),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white), // Border color
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownColor:
                  Color(0xFF343434), // Dropdown menu background color
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _usernameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle:
                    TextStyle(color: Colors.white), // Placeholder text color
                filled: true,
                fillColor: Color(0xFF343434),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Border color
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle:
                    TextStyle(color: Colors.white), // Placeholder text color
                filled: true,
                fillColor: Color(0xFF343434),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Border color
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle:
                    TextStyle(color: Colors.white), // Placeholder text color
                filled: true,
                fillColor: Color(0xFF343434),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, // Border color
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (!_isValidEmail(value!)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _signUp(context),
              child: Text('Sign Up'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFFB100CD)), // Button color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(
                    5.0), // Elevation of the button
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 24.0), // Increased vertical padding
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: Colors.white), // Text color
                ),
                tapTargetSize:
                    MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                animationDuration:
                    Duration(milliseconds: 200), // Animation duration
                shadowColor: MaterialStateProperty.all<Color>(
                  Colors.black.withOpacity(0.2), // Shadow color
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  Colors.white, // Text color
                ),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.white.withOpacity(0.2); // Hover color
                    }
                    return Color(0xFFB100CD); // Defer to the widget's default.
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerPage extends StatefulWidget {
  final String productName;
  final String productPrice;
  final String description;
  const CustomerPage({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.description,
  }) : super(key: key);
  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  List<Product> selectedProducts = [];
  List<Product> filteredProducts = []; // List to store filtered products
  TextEditingController searchController =
      TextEditingController(); // Controller for the search bar

  @override
  void initState() {
    super.initState();
    // Initialize selected products with dummy data
    double price = double.parse(widget.productPrice);
    selectedProducts = [
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
      Product(
        name: widget.productName,
        price: price,
        description: widget.description,
      )
    ];
    filteredProducts = selectedProducts;
  }

  void addToCart(Product product) {
    setState(() {
      product.isAddedToCart = true;
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      product.isAddedToCart = false;
    });
  }

  void searchProducts(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        // If search text is empty, show all products
        filteredProducts = selectedProducts;
      } else {
        // Otherwise, filter products based on search text
        filteredProducts = selectedProducts
            .where((product) =>
                product.name.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
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
              // Navigate to the shopping cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    selectedProducts: selectedProducts,
                    onRemove: (product) {
                      removeFromCart(product);
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: TextStyle(color: Colors.white), // Hint text color
                prefixIcon:
                    Icon(Icons.search, color: Color(0xFFB100CD)), // Search icon

                filled: true,
                fillColor: Color(0xFF343434), // Background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none, // Remove border
                ),
              ),
              style: TextStyle(color: Colors.white), // Text color
              onChanged: (value) {
                searchProducts(value); // Perform search as the text changes
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _getGridCount(
                    context), // Adjust grid count based on screen width
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return AnimatedProductCard(
                  // Add animation to product card
                  product: filteredProducts[index],
                  onPressed: () {
                    addToCart(filteredProducts[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to cart')),
                    );
                    Future.delayed(Duration(seconds: 1), () {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Determine the number of grid columns based on screen width
  int _getGridCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth ~/ 150; // Adjust the column width based on screen size
  }
}

// Custom animated product card widget
class AnimatedProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onPressed;

  AnimatedProductCard({
    required this.product,
    required this.onPressed,
  });

  @override
  _AnimatedProductCardState createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<AnimatedProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Card(
        elevation: 4.0,
        color: Color.fromARGB(128, 239, 196, 246), // Set background color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          onTap: widget.onPressed,
          child: Center(
            // Center the content vertically and horizontally
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ensure the column takes minimum space
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center horizontally
                children: [
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Center text horizontally
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: \Rs.${widget.product.price}',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center, // Center text horizontally
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    widget.product.description,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center, // Center text horizontally
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Product {
  final String name;
  final double price;
  final String description;
  bool isAddedToCart;

  Product({
    required this.name,
    required this.price,
    required this.description,
    this.isAddedToCart = false,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onPressed;

  const ProductCard({
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Color.fromARGB(128, 239, 196, 246), // Set background color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                color: Colors.grey[300], // Placeholder image color
              ),
              child: Center(
                child: Text(
                  product.name,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Description: ${product.description}',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(8.0)),
              ),
              child: Center(
                child: Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Product> selectedProducts;
  final Function(Product) onRemove;

  CartPage({required this.selectedProducts, required this.onRemove});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> cartProducts;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    // Initialize the list of cart products and total price
    cartProducts = widget.selectedProducts
        .where((product) => product.isAddedToCart)
        .toList();
    totalPrice = cartProducts.fold(0, (prev, product) => prev + product.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart Page',
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
      ),
      body: ListView.builder(
        itemCount: cartProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartProducts[index].name,
                style: TextStyle(color: Colors.white)),
            subtitle: Text('\Rs.${cartProducts[index].price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle,
                  color: Color.fromARGB(255, 255, 255, 255)),
              onPressed: () {
                // Remove the product from the list
                widget.onRemove(cartProducts[index]);
                // Update UI with the new list and total price
                setState(() {
                  // Filter out the removed product
                  cartProducts.removeAt(index);
                  // Recalculate the total price
                  totalPrice = cartProducts.fold(
                      0, (prev, product) => prev + product.price);
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Total Price: \Rs.${totalPrice.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Order Summary page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderSummaryPage(selectedProducts: cartProducts),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFB100CD), // Background color
                ),
                child: Text('Buy Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSummaryPage extends StatelessWidget {
  final List<Product> selectedProducts;

  OrderSummaryPage({required this.selectedProducts});

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        selectedProducts.fold(0, (prev, product) => prev + product.price);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Summary',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Purchase Details',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
            SizedBox(height: 20.0),
            Table(
              border: TableBorder.all(color: Colors.white), // Table border color
              columnWidths: {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Color(0xFFB100CD)), // Header row color
                  children: [
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Product Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Price (per unit)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (Product product in selectedProducts)
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            style: TextStyle(color: Colors.white), // Text color
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\Rs.${product.price.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.white), // Text color
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'Total Price: \Rs.${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Show snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Your order is placed'),
                  ),
                );
                // Return to previous page
                Navigator.push(
                context,
                MaterialPageRoute(
                  settings: RouteSettings(name: '/customer'), // Set the route name here
                  builder: (context) => CustomerPage(
                    productName: ' ',
                    productPrice: '0',
                    description: ' ',
                  ),
                ),
              );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFB100CD), // Background color
              ),
              child: Text('Place order'),
            ),
          ],
        ),
      ),
    );
  }
}
