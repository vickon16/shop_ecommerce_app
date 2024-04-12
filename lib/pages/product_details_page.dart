import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ecommerce_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        "id": widget.product["id"],
        "title": widget.product["title"],
        "price": widget.product["price"],
        "imageUrl": widget.product["imageUrl"],
        "company": widget.product["company"],
        "sizes": selectedSize,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product Added Successfully"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a size"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Text(widget.product["title"] as String,
              style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product["imageUrl"] as String,
              height: 300,
            ),
          ),
          const Spacer(flex: 2),
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(230, 230, 230, 1),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$${widget.product["price"]}",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product["sizes"] as List<int>).length,
                      itemBuilder: (context, index) {
                        final productSizes =
                            widget.product["sizes"] as List<int>;
                        final size = productSizes[index];

                        return GestureDetector(
                          onTap: () => {
                            setState(() {
                              selectedSize = size;
                            })
                          },
                          child: Chip(
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : const Color.fromRGBO(245, 245, 245, 1),
                            padding: const EdgeInsets.all(4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: const BorderSide(
                                width: 0.3,
                                color: Color.fromRGBO(110, 110, 110, 0.3)),
                            label: Text("$size"),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: const Size(250, 50),
                    ),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
