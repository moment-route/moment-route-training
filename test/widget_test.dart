import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moment_route_training/main.dart';

void main() {
  testWidgets('세 화면을 하단 내비게이션으로 이동할 수 있다', (tester) async {
    await tester.pumpWidget(const MomentRouteTrainingApp());

    expect(find.text('개발과 협업을 연습하는 공간입니다.'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person_outline_rounded));
    await tester.pumpAndSettle();
    expect(find.text('아직 준비되지 않았어요'), findsOneWidget);

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
}
