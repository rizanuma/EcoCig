import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildQuickIntroSection(),
            _buildSectionPreviews(context),
            _buildImpactSection(context),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green[400]!, Colors.green[800]!],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Transforming Cigarette Butts into Sustainable Footwear',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Every step you take helps clean our planet',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/products'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Shop Now', style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () => Navigator.pushNamed(context, '/about'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: BorderSide(color: Colors.white),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Learn More', style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/bin-locator'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text('Suggest a Bin Spot', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickIntroSection() {
    return Container(
      padding: EdgeInsets.all(64),
      child: Column(
        children: [
          Text(
            'What is Eco-Cig?',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Eco-Cig is a revolutionary initiative that transforms discarded cigarette butts into high-quality, sustainable footwear. By collecting and recycling these toxic waste products, we\'re not only cleaning our environment but also creating stylish, durable shoes that make a statement.',
            style: TextStyle(fontSize: 18, height: 1.6),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard('1M+', 'Cigarette Butts Recycled'),
              _buildStatCard('50K+', 'Pairs of Shoes Created'),
              _buildStatCard('100+', 'Cities Participating'),
              _buildStatCard('25K+', 'Happy Customers'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionPreviews(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(64),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'Explore Our Mission',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: _buildPreviewCard(
                  context,
                  'Sustainable Products',
                  'Discover our range of eco-friendly footwear made from recycled cigarette butts.',
                  Icons.eco,
                  '/products',
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _buildPreviewCard(
                  context,
                  'Environmental Awareness',
                  'Learn about the environmental impact of cigarette butts and how we\'re making a difference.',
                  Icons.public,
                  '/awareness',
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _buildPreviewCard(
                  context,
                  'Community Action',
                  'Join our community of environmental advocates and share your stories.',
                  Icons.group,
                  '/community',
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: _buildPreviewCard(
                  context,
                  'Bin Locator',
                  'Help us identify locations that need cigarette disposal bins.',
                  Icons.location_on,
                  '/bin-locator',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    String route,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.green[600]),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(height: 1.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, route),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
              child: Text('Explore'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(64),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.blue[700]!],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Your Impact Matters',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Every pair of shoes you buy prevents dozens of cigarette butts from polluting our environment for decades.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/products'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Text('Start Making a Difference', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
