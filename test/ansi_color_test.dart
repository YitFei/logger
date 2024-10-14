import '../lib/src/ansi_color.dart';
import 'package:test/test.dart';

//dart test test/ansi_color_test.dart
void main() {
  group(
    'AnsiColor',
    () {
      test('AnsiColor.none should have no fg or bg and color is false', () {
        const color = AnsiColor.none();
        expect(color.fg, isNull);
        expect(color.bg, isNull);
        expect(color.color, isFalse);
        expect(color.toString(), '');
        expect(color.call('Test'), 'Test');
        expect(color.resetForeground, '');
        expect(color.resetBackground, '');
      });

      test('AnsiColor.fg should set foreground color correctly', () {
        const color = AnsiColor.fg(34);

        expect(color.fg, 34);
        expect(color.bg, isNull);
        expect(color.color, isTrue);
        expect(color.toString(), '\x1B[38;5;34m');
        expect(color.call('Test'), '\x1B[38;5;34mTest\x1B[0m');
        expect(color.resetForeground, '\x1B[39m');
        expect(color.resetBackground, '\x1B[49m');
      });

      test('AnsiColor.bg should set background color correctly', () {
        const color = AnsiColor.bg(44);

        expect(color.fg, isNull);
        expect(color.bg, 44);
        expect(color.color, isTrue);
        expect(color.toString(), '\x1B[48;5;44m');
        expect(color.call('Test'), '\x1B[48;5;44mTest\x1B[0m');
        expect(color.resetForeground, '\x1B[39m');
        expect(color.resetBackground, '\x1B[49m');
      });

      test(
          'AnsiColor.fgBg should set both foreground and background colors correctly',
          () {
        const color = AnsiColor.fgBg(15, 196);
        expect(color.fg, 15);
        expect(color.bg, 196);
        expect(color.color, isTrue);
        expect(color.toString(), '\x1B[38;5;15m\x1B[48;5;196m');
        expect(color.call('Test'), '\x1B[38;5;15m\x1B[48;5;196mTest\x1B[0m');
        expect(color.resetForeground, '\x1B[39m');
        expect(color.resetBackground, '\x1B[49m');
      });

      test(
          'resetForeground should default foreground color without altering background',
          () {
        const color = AnsiColor.fgBg(15, 196);
        expect(color.resetForeground, '\x1B[39m');
      });

      test(
          'resetBackground should default background color without altering foreground',
          () {
        const color = AnsiColor.fgBg(15, 196);
        expect(color.resetBackground, '\x1B[49m');
      });
    },
  );

  const greenBgWithRedFg = AnsiColor.fgBg(196, 48);
  const redFg = AnsiColor.bg(196);
  const greenBg = AnsiColor.fg(48);

  print(redFg.call('Red foreground'));
  print(greenBg.call('Green background'));

  print(greenBgWithRedFg.call('White foreground with red background'));
  //foreground color background color
  print('\x1B[38;5;196m\x1B[48;5;48mtesting\x1B[0m');
  print('test');
}
