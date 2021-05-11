import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  final bool isTrainingPlayerMode;
  final double width;
  final double height;
  VideoPlayerScreen(this.videoPath, this.isTrainingPlayerMode, this.width, this.height);

  var isPlaying = false;

  void play(){isPlaying = true;}
  void pause(){isPlaying = false;}

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      widget.videoPath,
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    if (_controller.value.isPlaying) {
//      _controller.pause();
//    } else {
      if (widget.isPlaying) _controller.play(); else _controller.pause();
//    }

    if (widget.isTrainingPlayerMode) {
      _controller.play();
      return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          final Size size = _controller.value.size;
          if (size == null)
            return Container();
          else
            return ClipRect(
                child: OverflowBox(
                    maxWidth: MediaQuery
                        .of(context)
                        .size
                        .width,
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .width,
                    alignment: Alignment.center,
                    child: new FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                        child: new Container(
                            width: widget.width == -1.0 ? size.width == null ? 1 : size.width : widget.width,
                            height: widget.height == -1.0 ? size.height == null ? 1 : size.height : widget.height,
                            child: new VideoPlayer(_controller)
                        )
                    )
                )
            );
        },
      );
    } else {
      _controller.play();
      return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          final Size size = _controller.value.size;
          if (size == null)
            return Container();
          else
            return ClipRect(
                child: OverflowBox(
                    maxWidth: MediaQuery.of(context).size.width,
                    maxHeight: double.infinity,
                    alignment: Alignment.center,
                    child: new FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                        child: new Container(
                            width: size.width == null ? 1 : size.width,
                            height: size.height == null ? 1 : size.height,
                            child: new VideoPlayer(_controller)
                        )
                    )
                )
            );
        },
      );
    }

  }
}