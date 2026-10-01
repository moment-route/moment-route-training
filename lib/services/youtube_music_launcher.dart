import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class YouTubeMusicLauncher {
  static const MethodChannel channel = MethodChannel(
    'com.momentroute.moment_route_training/youtube_music',
  );

  Future<bool> isAvailable() async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return false;
    }

    return await channel.invokeMethod<bool>('isAvailable') ?? false;
  }

  Future<void> playFromSearch(String query) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      throw PlatformException(
        code: 'UNSUPPORTED_PLATFORM',
        message: 'YouTube Music 연결은 Android에서 사용할 수 있습니다.',
      );
    }

    await channel.invokeMethod<void>('playFromSearch', {'query': query});
  }
}
