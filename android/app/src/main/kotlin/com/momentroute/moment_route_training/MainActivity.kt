package com.momentroute.moment_route_training

import android.app.SearchManager
import android.content.Intent
import android.provider.MediaStore
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "com.momentroute.moment_route_training/youtube_music"
    private val youtubeMusicPackage = "com.google.android.apps.youtube.music"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAvailable" -> result.success(isYouTubeMusicAvailable())
                    "playFromSearch" -> {
                        val query = call.argument<String>("query")?.trim().orEmpty()
                        if (query.isEmpty()) {
                            result.error("INVALID_QUERY", "음악 검색어를 입력해 주세요.", null)
                            return@setMethodCallHandler
                        }

                        val intent = Intent(MediaStore.INTENT_ACTION_MEDIA_PLAY_FROM_SEARCH).apply {
                            setPackage(youtubeMusicPackage)
                            putExtra(
                                MediaStore.EXTRA_MEDIA_FOCUS,
                                MediaStore.Audio.Media.ENTRY_CONTENT_TYPE,
                            )
                            putExtra(SearchManager.QUERY, query)
                            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
                        }

                        if (intent.resolveActivity(packageManager) == null) {
                            result.error(
                                "YOUTUBE_MUSIC_UNAVAILABLE",
                                "YouTube Music 앱을 찾을 수 없어요.",
                                null,
                            )
                            return@setMethodCallHandler
                        }

                        try {
                            startActivity(intent)
                            result.success(null)
                        } catch (error: Exception) {
                            result.error(
                                "YOUTUBE_MUSIC_OPEN_FAILED",
                                "YouTube Music을 열지 못했어요.",
                                error.message,
                            )
                        }
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun isYouTubeMusicAvailable(): Boolean {
        val intent = Intent(MediaStore.INTENT_ACTION_MEDIA_PLAY_FROM_SEARCH).apply {
            setPackage(youtubeMusicPackage)
        }
        return intent.resolveActivity(packageManager) != null
    }
}
