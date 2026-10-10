import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quote_of_the_day/data/quotes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Random _random = Random();
  late int _currentIndex;
  late AnimationController _animController;

  List<Color> _buttonColors = const [
    Color(0xFF12142E),
    Color(0xFF4C3894),
    Color(0xFFB387E8),
    Color(0xFFF6C6E2),
  ];
  List<double> _buttonStops = const [0.125, 0.375, 0.625, 0.875];

  @override
  void initState() {
    super.initState();
    _currentIndex = _random.nextInt(quotes.length);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _loadMeshGradientConfig();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _loadMeshGradientConfig() async {
    try {
      final jsonStr = await rootBundle.loadString(
        'assets/mesh_gradient_animation.json',
      );
      final data = jsonDecode(jsonStr) as Map<String, dynamic>;
      final stops = data['stops'] as List<dynamic>?;
      final speed = (data['speed'] as num?)?.toDouble() ?? 20.0;
      if (speed > 0 && mounted) {
        final secs = (100 / speed).clamp(2.0, 30.0).round();
        _animController.duration = Duration(seconds: secs);
        _animController.repeat(reverse: true);
      }
      if (stops != null && stops.isNotEmpty) {
        final colors = <Color>[];
        final positions = <double>[];
        for (final stop in stops) {
          final rgb = stop['rgb'] as List<dynamic>?;
          if (rgb != null && rgb.length >= 3) {
            colors.add(
              Color.fromARGB(
                255,
                (rgb[0] as num).toInt(),
                (rgb[1] as num).toInt(),
                (rgb[2] as num).toInt(),
              ),
            );
          }
          final pos = stop['position'] as num?;
          if (pos != null) {
            positions.add(pos.toDouble());
          }
        }
        if (colors.isNotEmpty && mounted) {
          setState(() {
            _buttonColors = colors;
            if (positions.length == colors.length) {
              _buttonStops = positions;
            }
          });
        }
      }
    } catch (_) {}
  }

  void _newQuote() {
    int next;
    do {
      next = _random.nextInt(quotes.length);
    } while (next == _currentIndex);
    setState(() => _currentIndex = next);
  }

  @override
  Widget build(BuildContext context) {
    final quote = quotes[_currentIndex];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 85, 78, 111),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 153, 145, 197),
                  Color.fromARGB(255, 65, 81, 89),
                  Color.fromARGB(255, 35, 68, 97),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(
                    255,
                    197,
                    185,
                    207,
                  ).withOpacity(0.35),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 140,
            right: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 95, sigmaY: 95),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(
                    255,
                    163,
                    198,
                    231,
                  ).withOpacity(0.35),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    'QUOTE OF THE DAY',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                  ),
                  const Spacer(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: ClipRRect(
                      key: ValueKey(_currentIndex),
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 36,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.12),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 28,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                quote['text']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  letterSpacing: 0.2,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                '— ${quote['author']}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white.withOpacity(0.65),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(
                            255,
                            117,
                            97,
                            134,
                          ).withOpacity(0.4),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _newQuote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: AnimatedBuilder(
                        animation: _animController,
                        builder: (context, child) {
                          final t = _animController.value;
                          final wave = sin(t * pi);
                          final shift = (t - 0.5) * 1.4;
                          return Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-1.0 + shift, -0.6 + wave * 0.5),
                                end: Alignment(1.0 + shift, 0.6 - wave * 0.5),
                                colors: _buttonColors,
                                stops: _buttonStops,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: child,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 16,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'New Quote',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
