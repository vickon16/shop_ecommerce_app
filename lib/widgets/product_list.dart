import 'package:flutter/material.dart';
import 'package:shop_ecommerce_app/utils/constants.dart';
import 'package:shop_ecommerce_app/widgets/product_card.dart';
import 'package:shop_ecommerce_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ["All", "Adidas", "Nike", "Bata"];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(30),
      ),
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text("Shoes\nCollection",
                      style: Theme.of(context).textTheme.titleLarge),
                ),
                const Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      constraints: BoxConstraints.tightFor(height: 40),
                      contentPadding: EdgeInsets.all(2),
                      hintText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                        size: 18,
                      ),
                      prefixIconConstraints: BoxConstraints.tightFor(width: 30),
                      border: border,
                      enabledBorder: border,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(110, 110, 110, 1),
                        ),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          selectedFilter = filter;
                        })
                      },
                      child: Chip(
                        backgroundColor: selectedFilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 245, 245, 1),
                        padding: const EdgeInsets.all(4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        side: const BorderSide(
                            width: 0.3,
                            color: Color.fromRGBO(110, 110, 110, 0.3)),
                        label: Text(filter),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 1080) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.7,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailsPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product["title"] as String,
                        price: product["price"] as double,
                        image: product["imageUrl"] as String,
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(230, 230, 230, 1)
                            : const Color.fromRGBO(245, 245, 245, 1),
                      ),
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailsPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product["title"] as String,
                        price: product["price"] as double,
                        image: product["imageUrl"] as String,
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(230, 230, 230, 1)
                            : const Color.fromRGBO(245, 245, 245, 1),
                      ),
                    );
                  },
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
