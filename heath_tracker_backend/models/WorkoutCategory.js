const mongoose = require('mongoose');

// Exercise schema to store exercises within a category
const exerciseSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    duration: {
        type: Number,
        default: 30,  // Duration of exercise in minutes (default: 30 mins)
    },
    isDone: {
        type: Boolean,
        default: false  // Status if the user has completed the exercise
    }
});

// Category schema to store different workout categories (FullBody, LowerBody, AB)
const workoutCategorySchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,  // Name of the workout category (e.g., FullBody Workout)
    },
    itemTypes: {
        type: [String],  // Array of item types for the category (e.g., Equipment names)
    },
    exercises: [exerciseSchema],  // Multiple exercises under each category
    calories: {
        type: Number,  // Calories burned per workout session for this category
        required: true,
    },
    difficulty: {
        type: String,  // Difficulty level for the category (easy, medium, hard)
        required: true,
        enum: ['easy', 'medium', 'hard']  // Ensure it can only be one of these values
    }
}, { timestamps: true });


const WorkoutCategory = mongoose.model('WorkoutCategory', workoutCategorySchema, 'workoutCategories');
module.exports = WorkoutCategory;
