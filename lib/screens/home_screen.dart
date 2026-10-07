import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:quote_of_the_day/data/quotes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random _random = Random();
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = _random.nextInt(quotes.length);
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
          // Ambient background gradient
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

          // Top-left glowing ambient light orb
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

          // Bottom-right glowing ambient light orb
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

          // Main Interactive Layer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  const Spacer(),

                  // Subdued, modern category header
                  Text(
                    'QUOTE OF THE DAY',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                  ),

                  const Spacer(),

                  // Frosted Glass Quote Card with dynamic animation
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

                  // Modern Pill Refresh Button
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
                    child: FilledButton.icon(
                      onPressed: _newQuote,
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      label: const Text('New Quote'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 52, 73),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
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
