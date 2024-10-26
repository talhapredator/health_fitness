import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_tracker_app/providers/workout_detail_provider.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class WorkoutDetailScreen extends StatefulWidget {
  @override
  _WorkoutDetailScreenState createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  int _selectedReps = 30;  // Default repetitions
  int _caloriesBurn = 300; // Default calories burn based on 30 reps

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.asset('assets/images/jumping-jack.mp4');
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: true,
      fullScreenByDefault: false,
      allowFullScreen: true,
    );
    setState(() {});
  }

  void _updateCalories(int reps) {
    // Update calories dynamically as repetitions increase or decrease
    setState(() {
      _selectedReps = reps;
      _caloriesBurn = (200 + ((reps - 20) * 10));
    });
  }

  void _saveRepetitions() {
    // Use the provider to save the selected repetitions and calories
    final workoutDetailProvider = Provider.of<WorkoutDetailProvider>(context, listen: false);
    workoutDetailProvider.setRepetitions(_selectedReps, _caloriesBurn);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Repetitions saved: $_selectedReps with $_caloriesBurn Calories Burn')),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutDetailProvider = Provider.of<WorkoutDetailProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/workout2'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(workoutDetailProvider),
            _buildDescription(workoutDetailProvider),
            _buildSteps(workoutDetailProvider),
            SizedBox(height: 20),
            _buildCustomRepsSelector(),
            SizedBox(height: 20),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(WorkoutDetailProvider provider) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22), // Rounded corners
            ),
            child: Center(
              child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                  ? GestureDetector(
                onTap: () async {
                  _chewieController?.enterFullScreen();
                },
                // Applying the rounded corners using ClipRRect
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22), // Same radius as the Container
                  child: Chewie(controller: _chewieController!),
                ),
              )
                  : CircularProgressIndicator(),
            ),
          ),
          SizedBox(height: 35),
          Text(
            provider.workoutName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                provider.difficulty,
                style: TextStyle(color: Colors.blue),
              ),
              Text(' | ${provider.caloriesBurn} Calories Burn'),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildDescription(WorkoutDetailProvider provider) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descriptions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            provider.description,
            style: TextStyle(color: Colors.grey[600]),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Read More...', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  Widget _buildSteps(WorkoutDetailProvider provider) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How To Do It',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('${provider.steps.length} Steps', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provider.steps.length,
            itemBuilder: (context, index) {
              final step = provider.steps[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          step.number,
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            step.description,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomRepsSelector() {
    return Column(
      children: [
        Text(
          'Custom Repetitions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 100, // Height for the scrollable selector
          child: ListWheelScrollView(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.2,
            onSelectedItemChanged: (index) {
              _updateCalories(20 + index); // Reps range from 20 to 40
            },
            children: List.generate(21, (index) {
              int reps = 20 + index;
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Flame icon in red
                    Icon(
                      MaterialCommunityIcons.fire,
                      color: Colors.red,
                      size: 20, // Icon size
                    ),
                    SizedBox(width: 8), // Spacing between icon and text

                    // Calories burn text with smaller font size
                    Text(
                      '${200 + index * 10} Calories Burn',
                      style: TextStyle(fontSize: 9), // Smaller font size for calories
                    ),
                    SizedBox(width: 8),

                    // Repetitions text with larger reps font size and Times font size 16
                    Text(
                      '| $reps ',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Larger font for reps
                    ),
                    Text(
                      'Times',
                      style: TextStyle(fontSize: 16), // Font size 16 for 'Times'
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            primary: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: _saveRepetitions,
          child: Text(
            'Save',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
