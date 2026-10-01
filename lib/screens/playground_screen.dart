import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/youtube_music_launcher.dart';

class PlaygroundScreen extends StatefulWidget {
  const PlaygroundScreen({super.key});

  @override
  State<PlaygroundScreen> createState() => _PlaygroundScreenState();
}

class _PlaygroundScreenState extends State<PlaygroundScreen> {
  final _youtubeMusicLauncher = YouTubeMusicLauncher();
  final _musicQueryController = TextEditingController(text: '집중할 때 듣는 음악');
  int _buttonPressCount = 0;
  bool? _isYouTubeMusicAvailable;
  bool _isOpeningYouTubeMusic = false;

  @override
  void initState() {
    super.initState();
    _musicQueryController.addListener(_refreshMusicButton);
    _checkYouTubeMusic();
  }

  @override
  void dispose() {
    _musicQueryController
      ..removeListener(_refreshMusicButton)
      ..dispose();
    super.dispose();
  }

  void _refreshMusicButton() {
    setState(() {});
  }

  Future<void> _checkYouTubeMusic() async {
    try {
      final isAvailable = await _youtubeMusicLauncher.isAvailable();
      if (mounted) {
        setState(() => _isYouTubeMusicAvailable = isAvailable);
      }
    } on PlatformException {
      if (mounted) {
        setState(() => _isYouTubeMusicAvailable = false);
      }
    }
  }

  Future<void> _playWithYouTubeMusic() async {
    final query = _musicQueryController.text.trim();
    if (query.isEmpty || _isOpeningYouTubeMusic) return;

    FocusScope.of(context).unfocus();
    setState(() => _isOpeningYouTubeMusic = true);

    try {
      await _youtubeMusicLauncher.playFromSearch(query);
    } on PlatformException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? 'YouTube Music을 열지 못했어요.')),
      );
    } finally {
      if (mounted) {
        setState(() => _isOpeningYouTubeMusic = false);
      }
    }
  }

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
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.music_note_rounded, color: Color(0xFF657268)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'YouTube Music으로 이어 듣기',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  '듣고 싶은 분위기나 곡을 적으면, 휴대폰에 로그인된 YouTube Music에서 재생을 시도해요.',
                  style: TextStyle(color: Color(0xFF747A75), height: 1.5),
                ),
                const SizedBox(height: 18),
                TextField(
                  controller: _musicQueryController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _playWithYouTubeMusic(),
                  decoration: const InputDecoration(
                    labelText: '음악 검색어',
                    hintText: '예: 러닝할 때 듣는 신나는 음악',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed:
                        _isYouTubeMusicAvailable == true &&
                            _musicQueryController.text.trim().isNotEmpty &&
                            !_isOpeningYouTubeMusic
                        ? _playWithYouTubeMusic
                        : null,
                    icon: _isOpeningYouTubeMusic
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.open_in_new_rounded),
                    label: const Text('YouTube Music에서 재생'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  switch (_isYouTubeMusicAvailable) {
                    true => 'YouTube Music 앱이 연결되어 있어요.',
                    false =>
                      '이 기능은 YouTube Music이 설치된 Android 휴대폰에서 사용할 수 있어요.',
                    null => 'YouTube Music 앱을 확인하고 있어요…',
                  },
                  style: const TextStyle(
                    color: Color(0xFF747A75),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
