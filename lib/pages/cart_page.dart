import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/navbar.dart';
import '../components/footer.dart';
import '../utils/cart_provider.dart';
//import "package:ecocig/models/products.dart";
import '../models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return _buildEmptyCart(context);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildCartHeader(),
                _buildCartItems(context, cart),
                _buildCartSummary(context, cart),
                Footer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[400]),
          SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 24, color: Colors.grey[600]),
          ),
          SizedBox(height: 16),
          Text(
            'Add some eco-friendly products to get started!',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/products'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              textStyle: TextStyle(fontSize: 16),
            ),
            child: Text('Start Shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartHeader() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        children: [
          Icon(Icons.shopping_cart, color: Colors.green[800], size: 32),
          SizedBox(width: 16),
          Text(
            'Shopping Cart',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, CartProvider cart) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: cart.items.map((item) => _buildCartItem(context, item, cart)).toList(),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, CartProvider cart) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(item.product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item.product.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '\$${item.product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (item.quantity > 1) {
                          cart.updateQuantity(item.product.id, item.quantity - 1);
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline),
                      color: Colors.grey[600],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cart.updateQuantity(item.product.id, item.quantity + 1);
                      },
                      icon: Icon(Icons.add_circle_outline),
                      color: Colors.green[600],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    _showRemoveDialog(context, cart, item);
                  },
                  icon: Icon(Icons.delete_outline, color: Colors.red[600]),
                  label: Text(
                    'Remove',
                    style: TextStyle(color: Colors.red[600]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartProvider cart) {
    return Container(
      margin: EdgeInsets.all(32),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal (${cart.totalItems} items):'),
              Text('\$${cart.subtotal.toStringAsFixed(2)}'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping:'),
              Text(
                cart.subtotal >= 50 ? 'FREE' : '\$${cart.shippingCost.toStringAsFixed(2)}',
                style: TextStyle(
                  color: cart.subtotal >= 50 ? Colors.green[600] : null,
                  fontWeight: cart.subtotal >= 50 ? FontWeight.bold : null,
                ),
              ),
            ],
          ),
          if (cart.subtotal < 50)
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                'Free shipping on orders over \$50',
                style: TextStyle(fontSize: 12, color: Colors.grey[600], fontStyle: FontStyle.italic),
              ),
            ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax:'),
              Text('\$${cart.tax.toStringAsFixed(2)}'),
            ],
          ),
          Divider(height: 24, thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                '\$${cart.total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[700]),
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Column(
              children: [
                Icon(Icons.eco, color: Colors.green[600], size: 24),
                SizedBox(height: 8),
                Text(
                  'Environmental Impact',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[700]),
                ),
                SizedBox(height: 4),
                Text(
                  'Your purchase helps recycle ${cart.totalItems * 50} cigarette butts!',
                  style: TextStyle(fontSize: 14, color: Colors.green[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/products'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green[600],
                    side: BorderSide(color: Colors.green[600]!),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Continue Shopping'),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _proceedToCheckout(context, cart),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Proceed to Checkout'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showRemoveDialog(BuildContext context, CartProvider cart, CartItem item) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Remove Item'),
          content: Text('Are you sure you want to remove "${item.product.name}" from your cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                cart.removeItem(item.product.id);
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item.product.name} removed from cart'),
                    backgroundColor: Colors.green[600],
                    action: SnackBarAction(
                      label: 'Undo',
                      textColor: Colors.white,
                      onPressed: () {
                        cart.addItem(item.product, item.quantity);
                      },
                    ),
                  ),
                );
              },
              child: Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _proceedToCheckout(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.shopping_bag, color: Colors.green[600]),
              SizedBox(width: 8),
              Text('Checkout'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Summary:'),
              SizedBox(height: 8),
              Text('Items: ${cart.totalItems}'),
              Text('Total: \$${cart.total.toStringAsFixed(2)}'),
              SizedBox(height: 16),
              Text('Checkout functionality coming soon!', style: TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('Continue Shopping'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
