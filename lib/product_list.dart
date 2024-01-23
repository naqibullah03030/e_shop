import 'dart:math';

import 'package:e_shop/detail_page.dart';
import 'package:e_shop/global_variables.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final filters = const ["All", "Adidas", "Nike", "Bata"];

  Random math = Random.secure();

  int selected = 0;

  late List<Map<String, dynamic>> iproducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iproducts = products;
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          100,
        ),
        bottomLeft: Radius.circular(
          100,
        ),
        topRight: Radius.circular(
          10,
        ),
        bottomRight: Radius.circular(
          10,
        ),
      ),
      borderSide: BorderSide(
        width: 1,
        color: Color.fromRGBO(225, 225, 225, 1),
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
                const Text(
                  "Shoes\nCollection",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    onSubmitted: (String input) {
                      setState(() {
                        iproducts = products
                            .where((element) => element["title"]
                                .toString()
                                .contains(input.toLowerCase()))
                            .toList();
                      });
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      border: border,
                      enabledBorder: border,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = index;
                            debugPrint("$selected");
                            String input = filters[index];

                            iproducts = products.where((element) {
                              if (input == "All") {
                                return true;
                              } else {
                                return element["company"] == input;
                              }
                            }).toList();
                          });
                        },
                        child: Chip(
                          label: Text(
                            filters[index],
                          ),
                          labelStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15,
                          ),
                          backgroundColor: selected == index
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(247, 248, 249, 1),
                          // side: const BorderSide(width: 0),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ),
                    )),
                itemCount: filters.length,
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Map<String, dynamic> p = iproducts[index];

                  return GestureDetector(
                    onTap: () {
                      print(p);
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  DetailPage(product: p),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = const Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Color.fromRGBO(
                            math.nextInt(255),
                            math.nextInt(255),
                            math.nextInt(255),
                            math.nextInt(100) / 100),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${p['title']}",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Text(
                                "\$${p['price']}",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Center(
                                child: Image.asset(
                                  p["image"],
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: iproducts.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
