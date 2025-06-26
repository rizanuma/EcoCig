import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:provider/provider.dart'; // Add this import
import 'firebase_options.dart';

import 'pages/home_page.dart';
import 'pages/about_page.dart';
import 'pages/products_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/cart_page.dart';
import 'components/map_widget.dart';
import 'screens/login_screen.dart';
import 'utils/cart_provider.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure Firebase UI Auth providers
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(
      clientId: '1078226736187-q5peqbm3t78tq38sn5i7p1ic1kg0h9se.apps.googleusercontent.com',
    ),
  ]);

  runApp(const EcoCigApp());
}

class EcoCigApp extends StatelessWidget {
  const EcoCigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider( // Wrap with MultiProvider
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        // Add more providers here if needed
      ],
      child: MaterialApp(
        title: 'Eco-Cig | Sustainable Footwear from Cigarette Butts',
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Arial',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/about': (context) => const AboutPage(),
          '/products': (context) => const ProductsPage(),
          '/cart': (context) => const CartPage(),
          '/bin-locator': (context) => const MapWidget(),
          '/login': (context) => const LoginScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name != null && settings.name!.startsWith('/product/')) {
            final productId = settings.name!.split('/')[2];
            return MaterialPageRoute(
              builder: (context) => ProductDetailPage(productId: productId),
            );
          }
          return null;
        },
      ),
    );
  }
}