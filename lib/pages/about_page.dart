import 'package:flutter/material.dart';
import '../components/navbar.dart';
import '../components/footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMissionSection(),
            _buildLifecycleSection(),
            _buildTeamSection(),
            _buildCTASection(context),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionSection() {
    return Container(
      padding: EdgeInsets.all(64),
      child: Column(
        children: [
          Text(
            'Our Mission',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mission',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'To transform the world\'s most littered item - cigarette butts - into sustainable, high-quality footwear while raising awareness about environmental pollution.',
                      style: TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vision',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'A world where every cigarette butt is seen as a valuable resource, not waste, and where conscious consumers drive environmental change through their purchasing decisions.',
                      style: TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 48),
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Values',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildValueItem('Sustainability', 'Every decision we make prioritizes environmental health'),
                      _buildValueItem('Innovation', 'We constantly seek new ways to solve environmental challenges'),
                      _buildValueItem('Community', 'We believe collective action creates lasting change'),
                      _buildValueItem('Quality', 'Our products meet the highest standards of durability and comfort'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green[600], size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(description, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleSection() {
    return Container(
      padding: EdgeInsets.all(64),
      color: Colors.grey[100],
      child: Column(
        children: [
          Text(
            'From Waste to Wonder: The Lifecycle',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildLifecycleStep('1', 'Collection', 'Cigarette butts are collected from streets, beaches, and designated bins', Icons.delete_outline),
              _buildLifecycleStep('2', 'Cleaning', 'Industrial cleaning removes toxins and prepares materials for processing', Icons.cleaning_services),
              _buildLifecycleStep('3', 'Processing', 'Advanced technology transforms filters into durable textile fibers', Icons.settings),
              _buildLifecycleStep('4', 'Manufacturing', 'Skilled craftspeople create high-quality footwear from recycled materials', Icons.construction),
              _buildLifecycleStep('5', 'Impact', 'Each pair prevents pollution and supports environmental awareness', Icons.eco),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycleStep(String number, String title, String description, IconData icon) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green[600],
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 24),
                Text(
                  number,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14, height: 1.4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Container(
      padding: EdgeInsets.all(64),
      child: Column(
        children: [
          Text(
            'Our Team',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Meet the passionate individuals working to make our planet cleaner, one step at a time.',
            style: TextStyle(fontSize: 18, height: 1.6),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTeamMember('Dr. Sarah Green', 'Founder & CEO', 'Environmental scientist with 15 years of experience in sustainable innovation.'),
              _buildTeamMember('Mike Rodriguez', 'Head of Operations', 'Former Nike executive specializing in sustainable manufacturing processes.'),
              _buildTeamMember('Emma Chen', 'Lead Designer', 'Award-winning footwear designer passionate about eco-friendly fashion.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String name, String role, String bio) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green[200],
                child: Icon(Icons.person, size: 50, color: Colors.green[700]),
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                role,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12),
              Text(
                bio,
                style: TextStyle(fontSize: 14, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(64),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[400]!, Colors.green[800]!],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Join Our Mission',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 24),
          Text(
            'Whether you\'re a retailer, environmental organization, or conscious consumer, there are many ways to get involved.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text('Partner With Us', style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(width: 16),
              OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/community'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text('Join the Community', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
