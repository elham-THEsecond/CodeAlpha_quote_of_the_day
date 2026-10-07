import 'dart:math';

import 'package:flutter/material.dart';

const List<Map<String, String>> quotes = [
  {
    'text': 'The only way to do great work is to love what you do.',
    'author': 'Steve Jobs',
  },
  {
    'text': 'Life is what happens when you are busy making other plans.',
    'author': 'John Lennon',
  },
  {
    'text':
        'The future belongs to those who believe in the beauty of their dreams.',
    'author': 'Eleanor Roosevelt',
  },
  {
    'text':
        'It is during our darkest moments that we must focus to see the light.',
    'author': 'Aristotle',
  },
  {
    'text':
        'Do not go where the path may lead, go instead where there is no path and leave a trail.',
    'author': 'Ralph Waldo Emerson',
  },
  {
    'text':
        'The best time to plant a tree was 20 years ago. The second best time is now.',
    'author': 'Chinese Proverb',
  },
  {
    'text': 'Whether you think you can or you think you can\'t, you\'re right.',
    'author': 'Henry Ford',
  },
  {
    'text': 'The journey of a thousand miles begins with a single step.',
    'author': 'Lao Tzu',
  },
  {
    'text':
        'Success is not final, failure is not fatal: it is the courage to continue that counts.',
    'author': 'Winston Churchill',
  },
  {
    'text': 'In the middle of difficulty lies opportunity.',
    'author': 'Albert Einstein',
  },
];

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
    // Pick a random starting quote when the screen first appears.
    _currentIndex = _random.nextInt(quotes.length);
  }

  void _newQuote() {
    // Re-roll until we get a different index than the current one.
    int next;
    do {
      next = _random.nextInt(quotes.length);
    } while (next == _currentIndex);
    setState(() => _currentIndex = next);
  }

  @override
  Widget build(BuildContext context) {
    final quote = quotes[_currentIndex];
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Text(
                'Quote Of The Day',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
              ),
              const Spacer(),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: Card(
                  key: ValueKey(_currentIndex),
                  elevation: 0,
                  color: theme.colorScheme.surfaceContainerHighest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          quote['text']!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '— ${quote['author']}',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),
              FilledButton.icon(
                onPressed: _newQuote,
                icon: Icon(Icons.refresh),
                label: Text('New Quote'),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
