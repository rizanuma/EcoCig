import 'package:flutter/material.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Offset _panOffset = Offset.zero;
  double _zoom = 1.0;
  Offset? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.blue[50],
      child: Stack(
        children: [
          GestureDetector(
            onTapUp: (details) {
              setState(() {
                _selectedLocation = details.localPosition;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                _panOffset += details.delta;
              });
            },
            child: CustomPaint(
              painter: _MapPainter(_panOffset, _zoom, _selectedLocation),
              child: Container(), // Required 'child'
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Column(
              children: [
                _mapControlButton(Icons.add, _zoomIn),
                SizedBox(height: 8),
                _mapControlButton(Icons.remove, _zoomOut),
                SizedBox(height: 8),
                _mapControlButton(Icons.my_location, _getCurrentLocation),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _zoomIn() {
    setState(() {
      _zoom *= 1.1;
    });
  }

  void _zoomOut() {
    setState(() {
      _zoom /= 1.1;
    });
  }

  void _getCurrentLocation() async {
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return;

    setState(() {
      _panOffset = Offset.zero;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Centered on your location'),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  Widget _mapControlButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.green[800]),
        onPressed: onPressed,
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  final Offset panOffset;
  final double zoom;
  final Offset? selectedLocation;

  _MapPainter(this.panOffset, this.zoom, this.selectedLocation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1;

    for (double i = 0; i < size.height; i += 50 * zoom) {
      canvas.drawLine(
        Offset(0, i + panOffset.dy),
        Offset(size.width, i + panOffset.dy),
        paint,
      );
    }

    for (double i = 0; i < size.width; i += 50 * zoom) {
      canvas.drawLine(
        Offset(i + panOffset.dx, 0),
        Offset(i + panOffset.dx, size.height),
        paint,
      );
    }

    if (selectedLocation != null) {
      final redPaint = Paint()..color = Colors.red;
      canvas.drawCircle(selectedLocation!, 10, redPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
