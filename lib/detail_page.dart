import 'package:e_shop/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState(product);
}

class _DetailPageState extends State<DetailPage> {
  final Map<String, dynamic> product;
  late List<int> sizes;
  int selectedSize = 0;
  _DetailPageState(this.product);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sizes = product['sizes'];
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          children: [
            Text(
              product['title'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Image.asset(
              product['image'],
              width: double.infinity,
            ),
            const Spacer(
              flex: 2,
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(245, 247, 249, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      "\$${product['price']}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = index;
                              });
                            },
                            child: Chip(
                              backgroundColor: selectedSize == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              label: Text(
                                "${sizes[index]}",
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: sizes.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.black87),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.amber[300],
                          minimumSize: const Size(double.infinity, 40)),
                      onPressed: () {
                        Map<String, dynamic> temp = {
                          "id": product['id'],
                          "title": product['title'],
                          "price": product['price'],
                          "image": product['image'],
                          "company": product['company'],
                          "size": sizes[selectedSize],
                        };

                        cartProvider.addProduct(temp);

                        Navigator.pop(context);

                        SnackBar snackBar = const SnackBar(
                          content: Text(
                            "Successfully Added!",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          elevation: 2,
                          duration: Duration(
                            seconds: 2,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
