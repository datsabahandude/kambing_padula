import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds);
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Video Player'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: _controller.value.isInitialized
                    ? VideoPlayer(_controller)
                    : const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(39, 55, 144, 1),
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, VideoPlayerValue value, child) {
                        return Text(
                          _videoDuration(value.position),
                        );
                      }),
                  Expanded(
                      child: SizedBox(
                    height: 20,
                    child: VideoProgressIndicator(_controller,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 12)),
                  )),
                  Text(
                    _videoDuration(_controller.value.duration),
                  )
                ],
              ),
              Center(
                child: ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (context, VideoPlayerValue value, child) {
                      return IconButton(
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                          icon:
                              Icon(value.position == _controller.value.duration
                                  ? Icons.play_arrow
                                  : _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow));
                    }),
              ),
            ],
          ),
        ));
  }
}
