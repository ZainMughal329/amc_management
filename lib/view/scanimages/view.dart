// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(DastakFoodApp());
// }
//
// class DastakFoodApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dastak Food',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dastak Food'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Implement search functionality
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {
//               // Navigate to shopping cart
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Featured Restaurants Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Featured Restaurants',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               height: 200,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5, // Adjust based on the number of featured restaurants
//                 itemBuilder: (context, index) {
//                   // Create a widget for each featured restaurant
//                   return FeaturedRestaurantCard();
//                 },
//               ),
//             ),
//
//             // Categories Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Categories',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               height: 100,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 6, // Adjust based on the number of categories
//                 itemBuilder: (context, index) {
//                   // Create a widget for each category
//                   return CategoryCard();
//                 },
//               ),
//             ),
//
//             // Promotions Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 'Promotions',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Container(
//               height: 150,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 3, // Adjust based on the number of promotions
//                 itemBuilder: (context, index) {
//                   // Create a widget for each promotion
//                   return PromotionCard();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FeaturedRestaurantCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       margin: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.blue,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Restaurant Name',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           // Add restaurant image here
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: NetworkImage('https://placekitten.com/200/200'), // Replace with actual image URL
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CategoryCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       margin: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.orange,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Add category icon here
//           Icon(Icons.fastfood, color: Colors.white, size: 40),
//           SizedBox(height: 8),
//           Text(
//             'Category',
//             style: TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class PromotionCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       margin: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.green,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Promotion Title',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Description of the promotion goes here.',
//             style: TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  runApp(DastakFoodApp());
}

class DastakFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dastak Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dastak Food'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to shopping cart
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Restaurants Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Featured Restaurants',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return FeaturedRestaurantCard();
                },
              ),
            ),

            // Categories Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Container(
            //   height: 200,
            //   child: StaggeredGridView.countBuilder(
            //     crossAxisCount: 4,
            //     itemCount: 8,
            //     itemBuilder: (BuildContext context, int index) =>
            //         CategoryCard(index: index),
            //     staggeredTileBuilder: (int index) =>
            //         StaggeredTile.count(2, index.isEven ? 2 : 1),
            //     mainAxisSpacing: 8.0,
            //     crossAxisSpacing: 8.0,
            //   ),
            // ),

            // Promotions Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Promotions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 150,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1.0,
                ),
                items: List.generate(3, (index) => PromotionCard()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedRestaurantCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Restaurant Name',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://placekitten.com/200/200'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final int index;

  CategoryCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final categoryNames = ['Fast Food', 'Italian', 'Asian', 'Desserts', 'Drinks', 'Vegetarian', 'Seafood', 'Mexican'];
    final categoryColors = [Colors.orange, Colors.green, Colors.blue, Colors.purple, Colors.red, Colors.teal, Colors.amber, Colors.indigo];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: categoryColors[index % categoryColors.length],
      ),
      child: Center(
        child: Text(
          categoryNames[index % categoryNames.length],
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PromotionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage('https://placekitten.com/400/200'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Limited Time Offer',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '50% off on your first order!',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
