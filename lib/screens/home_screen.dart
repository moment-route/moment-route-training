import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onOpenProfile,
    required this.onOpenPlayground,
  });

  final VoidCallback onOpenProfile;
  final VoidCallback onOpenPlayground;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 36, 24, 24),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFF252B27),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.route_rounded, color: Colors.white),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Moment Route\nTraining',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1.05,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '개발과 협업을 연습하는 공간입니다.',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(color: const Color(0xFF626862)),
        ),
        const SizedBox(height: 36),
        _HomeCard(
          icon: Icons.badge_outlined,
          title: '나의 프로필 살펴보기',
          description: '화면에 보이는 정보가 코드와 어떻게 연결되는지 찾아보세요.',
          onTap: onOpenProfile,
        ),
        const SizedBox(height: 14),
        _HomeCard(
          icon: Icons.construction_outlined,
          title: '연습장에서 바꿔보기',
          description: '문구, 아이콘, 버튼을 부담 없이 바꿔볼 수 있어요.',
          onTap: onOpenPlayground,
        ),
      ],
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8ECE9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: const Color(0xFF3F4B43)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF747A75),
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
