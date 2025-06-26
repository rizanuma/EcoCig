import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/cart_provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.grey[200],
      title: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/'),
            child: Row(
              children: [
                Icon(Icons.eco, color: Colors.green[600], size: 32),
                SizedBox(width: 8),
                Text('Eco-Cig',
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )),
              ],
            ),
          ),
          Spacer(),
          if (MediaQuery.of(context).size.width > 768)
            _buildDesktopMenu(context)
          else
            _buildMobileMenuButton(context),
        ],
      ),
    );
  }

  Widget _buildDesktopMenu(BuildContext context) {
    return Row(
      children: [
        _buildNavItem(context, 'Home', '/'),
        _buildNavItem(context, 'About', '/about'),
        _buildNavItem(context, 'Products', '/products'),
        _buildNavItem(context, 'Awareness', '/awareness'),
        _buildNavItem(context, 'Bin Locator', '/bin-locator'),
        _buildNavItem(context, 'Community', '/community'),
        _buildNavItem(context, 'Contact', '/contact'),
        SizedBox(width: 16),
        _buildCartIcon(context),
      ],
    );
  }

  Widget _buildNavItem(BuildContext context, String title, String route) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isActive = currentRoute == route;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: isActive ? Colors.green[50] : Colors.transparent,
        ),
        child: Text(title,
          style: TextStyle(
            color: isActive ? Colors.green[600] : Colors.grey[700],
            fontSize: 16,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          )),
      ),
    );
  }

  Widget _buildCartIcon(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return Stack(
          children: [
            IconButton(
              onPressed: () => Navigator.pushNamed(context, '/cart'),
              icon: Icon(Icons.shopping_cart, color: Colors.green[600], size: 24),
              padding: EdgeInsets.all(8),
              style: IconButton.styleFrom(
                backgroundColor: Colors.green[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            if (cart.totalItems > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                  child: Text(
                    '${cart.totalItems > 99 ? '99+' : cart.totalItems}',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildMobileMenuButton(BuildContext context) {
    return Row(
      children: [
        _buildCartIcon(context),
        SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: Icon(Icons.menu, color: Colors.green[600]),
          onSelected: (route) => Navigator.pushNamed(context, route),
          itemBuilder: (context) => [
            PopupMenuItem(value: '/', child: Text('Home')),
            PopupMenuItem(value: '/about', child: Text('About')),
            PopupMenuItem(value: '/products', child: Text('Products')),
            PopupMenuItem(value: '/awareness', child: Text('Awareness')),
            PopupMenuItem(value: '/bin-locator', child: Text('Bin Locator')),
            PopupMenuItem(value: '/community', child: Text('Community')),
            PopupMenuItem(value: '/contact', child: Text('Contact')),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class StickyNavbar extends StatefulWidget {
  const StickyNavbar({super.key});

  @override
  StickyNavbarState createState() => StickyNavbarState();
}

class StickyNavbarState extends State<StickyNavbar> {
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _isScrolled ? Colors.white : Colors.transparent,
        boxShadow: _isScrolled
            ? [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
            : [],
      ),
      child: Navbar(),
    );
  }

  void updateScrollPosition(bool isScrolled) {
    if (_isScrolled != isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }
}
