/// This class handles colorizing of terminal output.
class AnsiColor {
  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const ansiDefault = '${ansiEsc}0m';

  final int? fg;
  final int? bg;
  final bool color;

  const AnsiColor.none()
      : fg = null,
        bg = null,
        color = false;

  const AnsiColor.fg(this.fg)
      : bg = null,
        color = true;

  const AnsiColor.bg(this.bg)
      : fg = null,
        color = true;

  //* This method for both color configuration
  const AnsiColor.fgBg(this.fg, this.bg) : color = (fg != null || bg != null);

  @override
  String toString() {
    final codes = <String>[];
    if (fg != null) codes.add('${ansiEsc}38;5;${fg}m');
    if (bg != null) codes.add('${ansiEsc}48;5;${bg}m');
    if (codes.isEmpty) return '';
    return codes.join('');
  }

  String call(String msg) {
    if (color) {
      final fgCode = fg != null ? '${ansiEsc}38;5;${fg}m' : '';
      final bgCode = bg != null ? '${ansiEsc}48;5;${bg}m' : '';

      return '$fgCode$bgCode$msg$ansiDefault';
    } else {
      return msg;
    }
  }

  AnsiColor toFg() => AnsiColor.fg(bg);

  AnsiColor toBg() => AnsiColor.bg(fg);

  /// Defaults the terminal's foreground color without altering the background.
  String get resetForeground => color ? '${ansiEsc}39m' : '';

  /// Defaults the terminal's background color without altering the foreground.
  String get resetBackground => color ? '${ansiEsc}49m' : '';

  static int grey(double level) => 232 + (level.clamp(0.0, 1.0) * 23).round();
}
