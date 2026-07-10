import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_project/main.dart';

void main() {
  testWidgets('Portfolio app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text('Divya Dholariya'), findsWidgets);
  });
}
