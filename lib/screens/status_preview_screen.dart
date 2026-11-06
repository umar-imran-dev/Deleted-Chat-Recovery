import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../l10n/app_localizations.dart';
import '../services/status_service.dart';
import '../theme/app_colors.dart';
import '../services/interstitial_ad_manager.dart';

class StatusPreviewScreen extends StatefulWidget {
  final StatusItem item;

  const StatusPreviewScreen({super.key, required this.item});

  @override
  State<StatusPreviewScreen> createState() => _StatusPreviewScreenState();
}

class _StatusPreviewScreenState extends State<StatusPreviewScreen> {
  // Video aur audio dono isi se chalte hain
  VideoPlayerController? _player;
  Future<Uint8List?>? _image;
  bool _playerFailed = false;
  bool _saving = false;
  bool _saved = false;

  bool get _isMedia => widget.item.isVideo || widget.item.isAudio;

  @override
  void initState() {
    super.initState();

    if (_isMedia) {
      final VideoPlayerController controller =
          VideoPlayerController.contentUri(Uri.parse(widget.item.uri));
      _player = controller;

      // Audio mein progress bar ko chalta rakhne ke liye
      controller.addListener(_onPlayerChanged);

      controller.initialize().then((_) {
        if (!mounted) return;
        controller.setLooping(true);
        controller.play();
        setState(() {});
      }).catchError((Object _) {
        if (mounted) setState(() => _playerFailed = true);
      });
    } else {
      _image = StatusService.instance.image(widget.item);
    }

    StatusService.instance.savedNames().then((names) {
      if (mounted) setState(() => _saved = names.contains(widget.item.name));
    });
  }

  void _onPlayerChanged() {
    if (mounted && widget.item.isAudio) setState(() {});
  }

  @override
  void dispose() {
    _player?.removeListener(_onPlayerChanged);
    _player?.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || _saved) return;
    final AppLocalizations t = AppLocalizations.of(context)!;

    setState(() => _saving = true);
    final bool ok = await StatusService.instance.save(widget.item);
    if (ok) unawaited(InterstitialAdManager.instance.onStatusSaved());
    if (!mounted) return;

    setState(() {
      _saving = false;
      _saved = ok;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? t.statusSaved : t.statusSaveFailed)),
    );
  }

  void _togglePlay() {
    final VideoPlayerController? player = _player;
    if (player == null) return;
    setState(() {
      player.value.isPlaying ? player.pause() : player.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors c = AppColors.current;
    final AppLocalizations t = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          scrolledUnderElevation: 0,
        ),
        body: Center(child: _content()),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: (_saving || _saved) ? null : _save,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Icon(_saved ? Icons.check_rounded : Icons.download_rounded),
                label: Text(
                  t.saveAction,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: c.accent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: _saved ? c.accent : c.grey(500),
                  disabledForegroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    if (_isMedia) {
      final VideoPlayerController? player = _player;

      if (_playerFailed) {
        return const Icon(
          Icons.videocam_off_rounded,
          color: Colors.white54,
          size: 56,
        );
      }
      if (player == null || !player.value.isInitialized) {
        return const CircularProgressIndicator(color: Colors.white);
      }

      // Audio: bara music icon, play/pause aur progress bar
      if (widget.item.isAudio) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.graphic_eq_rounded,
                color: Colors.white54,
                size: 110,
              ),
              const SizedBox(height: 24),
              VideoProgressIndicator(
                player,
                allowScrubbing: true,
                padding: const EdgeInsets.symmetric(vertical: 12),
                colors: const VideoProgressColors(
                  playedColor: Colors.white,
                  bufferedColor: Colors.white30,
                  backgroundColor: Colors.white12,
                ),
              ),
              const SizedBox(height: 8),
              IconButton(
                iconSize: 68,
                color: Colors.white,
                onPressed: _togglePlay,
                icon: Icon(
                  player.value.isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_fill_rounded,
                ),
              ),
            ],
          ),
        );
      }

      // Video: tap karne par pause / play
      return GestureDetector(
        onTap: _togglePlay,
        child: AspectRatio(
          aspectRatio: player.value.aspectRatio,
          child: VideoPlayer(player),
        ),
      );
    }

    return FutureBuilder<Uint8List?>(
      future: _image,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator(color: Colors.white);
        }
        final Uint8List? bytes = snapshot.data;
        if (bytes == null) {
          return const Icon(
            Icons.broken_image_rounded,
            color: Colors.white54,
            size: 56,
          );
        }
        return InteractiveViewer(
          child: Image.memory(bytes, fit: BoxFit.contain),
        );
      },
    );
  }
}