const mongoose = require('mongoose');

// User's workout progress schema
const userWorkoutProgressSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    category: {
        type: String,  // Category of workout (e.g., FullBody Workout)
        required: true
    },
    exercises: [{
        exerciseId: mongoose.Schema.Types.ObjectId, // Reference to the specific exercise
        isDone: { type: Boolean, default: false }, // Mark if exercise is done
    }]
}, { timestamps: true });

const UserWorkoutProgress = mongoose.model('UserWorkoutProgress', userWorkoutProgressSchema, 'userWorkoutProgress');
module.exports = UserWorkoutProgress;
