import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moment_route_training/main.dart';
import 'package:moment_route_training/services/youtube_music_launcher.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(YouTubeMusicLauncher.channel, (call) async {
          if (call.method == 'isAvailable') return true;
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(YouTubeMusicLauncher.channel, null);
  });

  testWidgets('세 화면을 하단 내비게이션으로 이동할 수 있다', (tester) async {
    await tester.pumpWidget(const MomentRouteTrainingApp());

    expect(find.text('개발과 협업을 연습하는 공간입니다.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Profile'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.extension_outlined));
    await tester.pumpAndSettle();
    expect(find.text('이 공간은 연습장입니다.'), findsOneWidget);
  });

  testWidgets('연습장 버튼의 횟수가 증가한다', (tester) async {
    await tester.pumpWidget(const MomentRouteTrainingApp());
    await tester.tap(find.byIcon(Icons.extension_outlined));
    await tester.pumpAndSettle();

    expect(find.text('버튼을 0번 눌렀어요'), findsOneWidget);
    await tester.tap(find.text('눌러보기'));
    await tester.pump();
    expect(find.text('버튼을 1번 눌렀어요'), findsOneWidget);
  });

  testWidgets('검색어를 YouTube Music 재생 요청으로 전달한다', (tester) async {
    MethodCall? playCall;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(YouTubeMusicLauncher.channel, (call) async {
          if (call.method == 'isAvailable') return true;
          playCall = call;
          return null;
        });

    await tester.pumpWidget(const MomentRouteTrainingApp());
    await tester.tap(find.byIcon(Icons.extension_outlined));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '출근길 신나는 음악');
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    final playButton = find.widgetWithText(FilledButton, 'YouTube Music에서 재생');
    await tester.tap(playButton);
    await tester.pump();

    expect(playCall?.method, 'playFromSearch');
    expect(playCall?.arguments, {'query': '출근길 신나는 음악'});
  });
}
