import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorDemoPage extends StatefulWidget {
  const SensorDemoPage({super.key});

  @override
  State<SensorDemoPage> createState() => _SensorDemoPageState();
}

class _SensorDemoPageState extends State<SensorDemoPage> {
  StreamSubscription<UserAccelerometerEvent>? _subscription;
  String _reading = 'Gerakkan ponsel secara perlahan.';

  @override
  void initState() {
    super.initState();
    _subscription = userAccelerometerEventStream().listen(
      (event) {
        if (!mounted) return;
        setState(() {
          _reading = 'x: ${event.x.toStringAsFixed(2)} | '
              'y: ${event.y.toStringAsFixed(2)} | '
              'z: ${event.z.toStringAsFixed(2)} m/s²';
        });
      },
      onError: (Object error) {
        if (mounted) {
          setState(() => _reading = 'Sensor tidak tersedia: $error');
        }
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo Sensor Accelerometer')),
      body: Center(
        child: Text(_reading, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}