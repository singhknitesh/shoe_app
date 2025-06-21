import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sh_app/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> hoverAnimation;

  //list fo products
  List<Product> products = [
    Product(
      name: 'RED TAPE SNEAKER',
      price: 1999,
      color: const Color(0xff000000),
      image: 'assets/images/shoes1.png',
    ),
    Product(
      name: 'JORDON SHOES',
      price: 2999,
      color: const Color(0xfffcecd0),
      image: 'assets/images/shoes2.png',
    ),
    Product(
      name: 'ADDIDAS SHOES',
      price: 2599,
      color: const Color(0xffb6d7e4),
      image: 'assets/images/shoes3.png',
    ),
    Product(
      name: 'NIKE SHOES',
      price: 3599,
      color: const Color.fromARGB(255, 69, 75, 77),
      image: 'assets/images/shoes4.png',
    ),
  ];

  int currentIndex = 0;

  //constants colors
  Color black = const Color(0xff000000);
  Color cream = const Color(0xfffcecd0);
  Color blue = const Color(0xffb6d7e4);

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(
        reverse: true,
      );
    hoverAnimation =
        Tween(begin: const Offset(0, 0), end: const Offset(0, 0.02))
            .animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final currentProduct = products[currentIndex];
    return Scaffold(
      backgroundColor: const Color(0xff292929),
      body: SafeArea(
        child: Column(
          children: [
            SlideTransition(
              position: hoverAnimation,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                child: Image.asset(
                  products[currentIndex].image,
                  key: ValueKey<int>(currentIndex),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              currentProduct.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Comfortabe Shoes',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(products.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: products[index].color,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 30,
            ),
             Text(
              'Rs. ${currentProduct.price}',
              style: const TextStyle(
                  color: Color.fromARGB(255, 239, 232, 231),
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              color: Color.fromRGBO(234, 154, 17, 1),
              height: 40,
              child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addProduct({
                        'name' : currentProduct.name,
                        'price': currentProduct.price,
                        'color': currentProduct.color,
                        'image': currentProduct.image,
 // Example product name
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final int price;
  final Color color;
  final String image;

  Product({required this.color, required this.image, required this.name, required this.price});
}
