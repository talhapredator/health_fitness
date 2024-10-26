const mongoose = require('mongoose');

// Steps schema for how to perform an exercise
const stepSchema = new mongoose.Schema({
    stepNumber: { type: Number, required: true },
    description: { type: String, required: true }
});

// Workout Exercise schema
const workoutExerciseSchema = new mongoose.Schema({
    name: { type: String, required: true }, // Exercise name (e.g., Jumping Jacks)
    description: { type: String, required: true }, // Description of the exercise
    steps: [stepSchema], // Array of steps for how to perform the exercise
    duration: { type: Number, required: true }, // Duration in minutes (e.g., 30 minutes)
    difficulty: { type: String, required: true }, // Difficulty level (easy, medium, hard)
    baseCalories: { type: Number, required: true }, // Base calories burned per set duration
}, { timestamps: true });

const WorkoutExercise = mongoose.model('WorkoutExercise', workoutExerciseSchema);
module.exports = WorkoutExercise;
