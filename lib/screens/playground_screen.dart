import 'package:flutter/material.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  int _buttonPressCount = 0;

  void _pressButton() {
    setState(() {
      _buttonPressCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
      children: [
        Text(
          'Playground',
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        const Text(
          '이 화면에서는 작은 실험을 마음껏 해도 괜찮아요.',
          style: TextStyle(color: Color(0xFF747A75)),
        ),
        const SizedBox(height: 28),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  size: 52,
                  color: Color(0xFF657268),
                ),
                const SizedBox(height: 18),
                Text(
                  '이 공간은 연습장입니다.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                const Text(
                  '문구나 아이콘을 바꾸고, 새로운 위젯도 하나 추가해 보세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF747A75), height: 1.5),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _pressButton,
                    icon: const Icon(Icons.touch_app_rounded),
                    label: const Text('눌러보기'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  '버튼을 $_buttonPressCount번 눌렀어요',
                  style: const TextStyle(color: Color(0xFF747A75)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
