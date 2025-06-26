import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main footer content
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 32),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 768) {
                  return _buildDesktopFooter(context);
                } else {
                  return _buildMobileFooter(context);
                }
              },
            ),
          ),
          
          // Bottom bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border(
                top: BorderSide(color: Colors.grey[700]!, width: 1),
              ),
            ),
            child: _buildBottomBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildBrandSection(context)),
        const SizedBox(width: 60),
        Expanded(child: _buildQuickLinksSection(context)),
        const SizedBox(width: 40),
        Expanded(child: _buildProductsSection(context)),
        const SizedBox(width: 40),
        Expanded(child: _buildCommunitySection(context)),
        const SizedBox(width: 40),
        Expanded(child: _buildContactSection(context)),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandSection(context),
        const SizedBox(height: 40),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildQuickLinksSection(context)),
            const SizedBox(width: 30),
            Expanded(child: _buildProductsSection(context)),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildCommunitySection(context)),
            const SizedBox(width: 30),
            Expanded(child: _buildContactSection(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.eco, color: Colors.green[400], size: 32),
            const SizedBox(width: 12),
            const Text(
              'Eco-Cig',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Transforming cigarette waste into sustainable products. Join us in creating a cleaner, greener future.',
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 24),
        _buildSocialIcons(),
        const SizedBox(height: 20),
        _buildNewsletterSignup(context),
      ],
    );
  }

  Widget _buildQuickLinksSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Quick Links'),
        const SizedBox(height: 16),
        _buildFooterLink(context, 'Home', '/'),
        _buildFooterLink(context, 'About Us', '/about'),
        _buildFooterLink(context, 'Our Mission', '/about'),
        _buildFooterLink(context, 'How It Works', '/about'),
        _buildFooterLink(context, 'Partnerships', '/contact'),
      ],
    );
  }

  Widget _buildProductsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Products'),
        const SizedBox(height: 16),
        _buildFooterLink(context, 'All Products', '/products'),
        _buildFooterLink(context, 'Footwear', '/products'),
        _buildFooterLink(context, 'Size Guide', '/products'),
        _buildFooterLink(context, 'Care Instructions', '/products'),
        _buildFooterLink(context, 'Wholesale', '/contact'),
      ],
    );
  }

  Widget _buildCommunitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Community'),
        const SizedBox(height: 16),
        _buildFooterLink(context, 'Discussion Forum', '/community'),
        _buildFooterLink(context, 'Success Stories', '/community'),
        _buildFooterLink(context, 'Bin Locator', '/bin-locator'),
        _buildFooterLink(context, 'Awareness', '/awareness'),
        _buildFooterLink(context, 'Volunteer', '/contact'),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Contact'),
        const SizedBox(height: 16),
        _buildContactItem(Icons.email, 'hello@eco-cig.com', () => _launchEmail()),
        _buildContactItem(Icons.phone, '+91 9876543210', () => _launchPhone()),
        _buildContactItem(Icons.location_on, 'Coimbatore, Tamil Nadu', null),
        const SizedBox(height: 12),
        _buildFooterLink(context, 'Contact Form', '/contact'),
        _buildFooterLink(context, 'Support', '/contact'),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String text, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, VoidCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.green[400], size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      children: [
        _buildSocialIcon(Icons.facebook, 'Facebook', 'https://facebook.com'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.language, 'Twitter', 'https://twitter.com'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.camera_alt, 'Instagram', 'https://instagram.com'),
        const SizedBox(width: 12),
        _buildSocialIcon(Icons.play_circle, 'YouTube', 'https://youtube.com'),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String platform, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: Colors.green[400],
          size: 20,
        ),
      ),
    );
  }

  Widget _buildNewsletterSignup(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stay Updated',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Get latest updates on our mission and products',
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _handleNewsletterSubscription(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(fontSize: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text('Subscribe'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 768) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCopyright(),
              _buildLegalLinks(),
            ],
          );
        } else {
          return Column(
            children: [
              _buildCopyright(),
              const SizedBox(height: 12),
              _buildLegalLinks(),
            ],
          );
        }
      },
    );
  }

  Widget _buildCopyright() {
    return Text(
      '© 2024 Eco-Cig. All rights reserved. Made with ♻️ for a sustainable future.',
      style: TextStyle(
        color: Colors.grey[400],
        fontSize: 12,
      ),
    );
  }

  Widget _buildLegalLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLegalLink('Privacy Policy'),
        Text(' • ', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        _buildLegalLink('Terms of Service'),
        Text(' • ', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
        _buildLegalLink('Cookie Policy'),
      ],
    );
  }

  Widget _buildLegalLink(String text) {
    return GestureDetector(
      onTap: () => _showLegalDialog(text),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 12,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // Helper methods for handling interactions
  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hello@eco-cig.com',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+919876543210',
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  void _handleNewsletterSubscription(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Newsletter subscription feature coming soon!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showLegalDialog(String title) {
    // This would typically show a dialog with the legal document
    // For now, we'll just show a placeholder
  }
}