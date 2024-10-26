const WorkoutExercise = require('../models/WorkoutExercise');

// Fetch all exercises for a workout category
const getExercisesByCategory = async (req, res) => {
    try {
        const exercises = await WorkoutExercise.find({}); // Fetch all exercises (can be filtered by category)
        res.status(200).json(exercises);
    } catch (error) {
        res.status(500).json({ error: 'Error fetching exercises' });
    }
};

module.exports = { getExercisesByCategory };
