import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

Widget settingsOverlay(BuildContext context, game) {
  final gameProvider = Provider.of<GameProvider>(context, listen: true);
  return Center(
    child: Container(
      width: 350,
      height: 400,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 180, 150, 200), // Purple color
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Settings",
            style: TextStyle(color: Colors.black, fontSize: 48),
          ),
          const SizedBox(height: 20),

          // Music volume slider
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.music_note),
              ),
              Expanded(
                child: Slider(
                  value: gameProvider.musicVolume,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: gameProvider.musicVolume.toStringAsFixed(1),
                  onChanged: (value) {
                    gameProvider.setMusicVolume(value);
                  },
                ),
              ),
            ],
          ),

          // Sound effects volume slider
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.volume_up),
              ),
              Expanded(
                child: Slider(
                  value: gameProvider.sfxVolume,
                  min: 0,
                  max: 100,
                  divisions: 5,
                  label: gameProvider.sfxVolume.toStringAsFixed(1),
                  onChanged: (value) {
                    gameProvider.setSfxVolume(value);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              game.overlays.remove('settings');
              game.paused = false;
            },
            child: const Text("Close"),
          ),
        ],
      ),
    ),
  );
}
