import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_tracker_app/providers/workout_provider.dart';

class WorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    return PopScope(
      onPopInvoked: (bool willPop) {
        if (willPop) {
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 400,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/workout');
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.more_horiz, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff62cff4), Color(0xff2c67f2)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/fitness-1-remove.png', // Image of a fitness person skipping
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workoutProvider.workoutName,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '11 Exercises | ${workoutProvider.duration.inMinutes} min | ${workoutProvider.calories} Calories Burn',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildScheduleAndDifficultyButtons(context, workoutProvider),
                    SizedBox(height: 35),
                    Text(
                      "You'll Need",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    _buildEquipmentSection(workoutProvider),
                    SizedBox(height: 25),
                    Text(
                      'Exercises',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    _buildExercisesSection(workoutProvider),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleAndDifficultyButtons(BuildContext context, WorkoutProvider provider) {
    return Column(

      children: [
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: provider.scheduleTime,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (picked != null && picked != provider.scheduleTime) {
              provider.scheduleWorkout(picked);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.schedule, color: Color(0xff2979ff)),
                    SizedBox(width: 8),
                    Text('Schedule Workout'),
                  ],
                ),
                Text(
                  provider.scheduleTime != null
                      ? '${provider.scheduleTime.day}/${provider.scheduleTime.month}/${provider.scheduleTime.year}'
                      : 'Not Set',
                  style: TextStyle(color: Color(0xff2979ff)),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xffe3f2fd),
            onPrimary: Color(0xff2979ff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.speed, color: Color(0xfff48fb1)),
                    SizedBox(width: 8),
                    Text('Difficulty'),
                  ],
                ),
                Text(
                  'Beginner', // or provider.currentDifficulty if you want dynamic value
                  style: TextStyle(color: Color(0xfff48fb1)),
                ),
              ],
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xfffce4ec),
            onPrimary: Color(0xfff48fb1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildEquipmentSection(WorkoutProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: provider.equipment.map((item) => _buildEquipmentItem(item)).toList(),
    );
  }

  Widget _buildEquipmentItem(String item) {
    return Column(
      children: [
       SizedBox(height: 20),
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(22),
          ),
          child: Icon(Icons.fitness_center, size: 30, color: Colors.blue),
        ),
        SizedBox(height: 10),
        Text(item, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildExercisesSection(WorkoutProvider provider) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: provider.exercises.length,
      itemBuilder: (context, index) {
        final exercise = provider.exercises[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, '/workdetail');
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(exercise.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(exercise.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(exercise.duration, style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
                Icon(Icons.play_circle_outline, size: 30, color: Colors.blue),
              ],
            ),
          ),
        );
      },
    );
  }
}
