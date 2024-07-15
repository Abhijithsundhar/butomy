import 'package:flutter/material.dart';
import 'package:techbutomy/feature/home/screens/homescreen.dart';
import 'package:techbutomy/model/categoryModel.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key, required this.dish});
  final List<Product> dish;

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late Map<Product, int> productQuantities;

  @override
  void initState() {
    super.initState();
    productQuantities = {};
    for (var product in widget.dish) {
      if (productQuantities.containsKey(product)) {
        productQuantities[product] = productQuantities[product]! + 1;
      } else {
        productQuantities[product] = 1;
      }
    }
  }

  void incrementQuantity(Product product) {
    setState(() {
      productQuantities[product] = productQuantities[product]! + 1;
    });
  }

  void decrementQuantity(Product product) {
    setState(() {
      if (productQuantities[product]! > 1) {
        productQuantities[product] = productQuantities[product]! - 1;
      }
    });
  }

  void clearCart() {
    setState(() {
      productQuantities.clear();
      widget.dish.clear();
    });
  }

  void placeOrder() {
    clearCart();
    widget.dish.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully')),
    );
    Future.delayed(const Duration(milliseconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const BackButton(),
        ),
        title: const Text('My Cart'),
        actions: [
          GestureDetector(
            onTap: clearCart,
            child: Container(
              width: width * .26,
              height: height * .04,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: const [Icon(Icons.delete), Text(' Clear Cart')],
              ),
            ),
          ),
          SizedBox(
            width: width * .04,
          ),
        ],
      ),
      body: productQuantities.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: productQuantities.length,
                    itemBuilder: (context, index) {
                      final product = productQuantities.keys.elementAt(index);
                      final quantity = productQuantities[product]!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: height * .025,
                                width: width * .05,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red.shade600),
                                ),
                                child: Icon(
                                  Icons.circle,
                                  color: Colors.red.shade600,
                                  size: width * .025,
                                ),
                              ),
                              SizedBox(width: width * .015),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: height * .01),
                                  SizedBox(
                                    width: width * .3,
                                    child: Text(product.name),
                                  ),
                                  Text('₹${product.price.toStringAsFixed(0)}'),
                                ],
                              ),
                              SizedBox(width: width * .05),
                              Container(
                                width: width * .28,
                                height: height * .04,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () => decrementQuantity(product),
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text('$quantity'),
                                    IconButton(
                                      onPressed: () => incrementQuantity(product),
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  Text('₹${(product.price * quantity).toStringAsFixed(0)}'),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: width * .03),
                child: const Text(
                  'Bill Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Item Total'),
                          Text('₹${productQuantities.entries.map((entry) => entry.key.price * entry.value).reduce((a, b) => a + b).toStringAsFixed(2)}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Taxes & charges'),
                          Text('₹57.40'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'GRAND TOTAL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('₹${(productQuantities.entries.map((entry) => entry.key.price * entry.value).reduce((a, b) => a + b) + 57.40).toStringAsFixed(2)}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: width * .1, top: height * .18),
                child: GestureDetector(
                  onTap: placeOrder,
                  child: Container(
                    width: width * .7,
                    height: height * .05,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        'Place Order',
                        style: TextStyle(
                          fontSize: width * .04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : const Center(child: Text('No items in cart')),
    );
  }
}
