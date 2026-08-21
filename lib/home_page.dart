import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'cart_page.dart';
import 'book.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  int cartTotal = 0;
  bool isAbsorbing = false;
  List<Book> cartBooks = [];



  final Book hp = Book(image: 'assets/images/hp.jpg', price: 299);
  final Book witcher = Book(image: 'assets/images/witcher.jpg', price: 349);
  final Book horror = Book(image: 'assets/images/horror.jpg', price: 199);
  final Book mystery = Book(image: 'assets/images/mystery.jpg', price: 249);
  final Book fantasy = Book(image: 'assets/images/fantasy.jpg', price: 299);


  Widget draggableBook(Book book) {
    return Draggable<Book>(
      data: book,
      feedback: Image.asset(book.image, height: 120),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: Image.asset(book.image, height: 120),
      ),
      child: Image.asset(book.image, height: 120),
    );
  }
  Widget _genreColumn(Book book, String title) {
    return Column(
      children: [
        draggableBook(book),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),

      appBar: AppBar(
        title: const Text(
          "BookNest",
          style: TextStyle(
            color: Color.fromARGB(255, 241, 238, 216),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 57, 68),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isLoggedIn', false);

              if (!context.mounted) return;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const Login(showLogoutSnack: true),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [

          /// MAIN CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Welcome to BookNest",
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        draggableBook(hp),
                        const SizedBox(width: 16),
                        draggableBook(witcher),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Discover More Reads",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Explore a wider collection of books across genres. From fantasy and fiction to mystery and classics, BookNest helps you find stories that match your interests.",
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        _genreColumn(horror, 'Horror'),
                        const SizedBox(width: 16),
                        _genreColumn(mystery, 'Mystery'),
                        const SizedBox(width: 16),
                        _genreColumn(fantasy, 'Fantasy'),
                                          ],
                    ),
                  ],
                ),
              ),
            ),
          ),
         
        ],
      ),
       floatingActionButton: DragTarget<Book>(
              onAcceptWithDetails: (details) {
                setState(() {
                  cartTotal += details.data.price;
                  cartBooks.add(details.data); // 👈 store book
                  isAbsorbing = true;
                });

                Future.delayed(const Duration(milliseconds: 250), () {
                  if (mounted) {
                    setState(() {
                      isAbsorbing = false;
                    });
                  }
                });
              },

              builder: (context, candidateData, rejectedData) {
            final isHovering = candidateData.isNotEmpty;

            return AnimatedScale(
              scale: isAbsorbing ? 1.25 : (isHovering ? 1.15 : 1.0),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: isAbsorbing
                      ? [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.6),
                            blurRadius: 25,
                            spreadRadius: 5,
                          ),
                        ]
                      : [],
                ),
                child: FloatingActionButton.extended(
                  backgroundColor: isAbsorbing
                      ? Colors.orange
                      : const Color.fromARGB(134, 249, 245, 18),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: isAbsorbing ? Colors.white : Colors.black,
                  ),
                  label: Text(
                    "₹$cartTotal",
                    style: TextStyle(
                      color: isAbsorbing ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CartPage(
                          cartBooks: cartBooks,
                          total: cartTotal,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },

        ),
    );
  }
  
  
}
