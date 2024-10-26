const mongoose = require('mongoose');
const WorkoutCategory = require('../models/WorkoutCategory');
const WorkoutExercise = require('../models/WorkoutExercise');

// MongoDB connection string (ensure it's correct for your environment)
const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://localhost:27017/health_tracker';

// Sample data to seed
const categories = [
    {
        name: 'FullBody Workout',
        itemTypes: ['Dumbbells', 'Resistance Bands'],
        exercises: [
            { name: 'Jumping Jacks', duration: 30 },
            { name: 'Push-ups', duration: 30 },
            { name: 'Squats', duration: 30 }
        ],
        calories: 320,  // Full Body Workout burns 320 calories
        difficulty: 'easy'  // Difficulty level
    },
    {
        name: 'LowerBody Workout',
        itemTypes: ['Dumbbells', 'Barbell'],
        exercises: [
            { name: 'Lunges', duration: 30 },
            { name: 'Leg Press', duration: 30 }
        ],
        calories: 250,  // Lower Body Workout burns 250 calories
        difficulty: 'medium'  // Difficulty level
    },
    {
        name: 'AB Workout',
        itemTypes: ['Yoga Mat'],
        exercises: [
            { name: 'Crunches', duration: 30 },
            { name: 'Planks', duration: 30 }
        ],
        calories: 200,  // AB Workout burns 200 calories
        difficulty: 'hard'  // Difficulty level
    }
];

const exercises = [
    {
        name: 'Jumping Jacks',
        description: 'A physical jumping exercise by jumping to a position with legs spread wide.',
        steps: [
            { stepNumber: 1, description: 'Spread Your Arms' },
            { stepNumber: 2, description: 'Rest at The Toe' },
            { stepNumber: 3, description: 'Adjust Foot Movement' },
            { stepNumber: 4, description: 'Clap Both Hands' }
        ],
        duration: 30,  // In minutes
        difficulty: 'easy',
        baseCalories: 320  // For 30 minutes
    },
    {
        name: 'Push-ups',
        description: 'A basic exercise to strengthen upper body muscles.',
        steps: [
            { stepNumber: 1, description: 'Get into a high plank position' },
            { stepNumber: 2, description: 'Lower your body down towards the floor' },
            { stepNumber: 3, description: 'Push yourself back up' }
        ],
        duration: 30,
        difficulty: 'medium',
        baseCalories: 250
    },
    {
        name: 'Squats',
        description: 'An exercise targeting lower body muscles.',
        steps: [
            { stepNumber: 1, description: 'Stand with feet shoulder-width apart' },
            { stepNumber: 2, description: 'Lower your body down as if sitting in a chair' },
            { stepNumber: 3, description: 'Stand back up' }
        ],
        duration: 30,
        difficulty: 'medium',
        baseCalories: 250
    }
];

// Function to seed workout categories
const seedWorkoutCategories = async () => {
    try {
        // Connect to MongoDB
        await mongoose.connect(MONGODB_URI, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        });
        console.log('Connected to MongoDB');

        // Clear existing data (optional)
        await WorkoutCategory.deleteMany({});
        await WorkoutExercise.deleteMany({});
        console.log('Cleared existing workout categories');

        // Insert seed data
        await WorkoutCategory.insertMany(categories);
        await WorkoutExercise.insertMany(exercises);
        console.log('Workout categories seeded successfully');

        // Close the database connection
        mongoose.connection.close();
        console.log('MongoDB connection closed');
    } catch (error) {
        console.error('Error seeding workout categories:', error);
        mongoose.connection.close();
    }
};

// Run the seed function
seedWorkoutCategories();
