const express = require('express');
const WorkoutCategory = require('../models/WorkoutCategory');
const UserWorkoutProgress = require('../models/UserWorkoutProgress');
const { getExercisesByCategory } = require('../controllers/workoutController');
const jwt = require('jsonwebtoken');

const router = express.Router();

router.get('/exercises', getExercisesByCategory);

// Get all workout categories for the user to select from
router.get('/categories', async (req, res) => {
    try {
        const categories = await WorkoutCategory.find({});
        res.json(categories);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

// Get exercises for a selected category
router.get('/category/:categoryId/exercises', async (req, res) => {
    try {
        const category = await WorkoutCategory.findById(req.params.categoryId);
        if (!category) return res.status(404).json({ message: 'Category not found' });

        res.json(category.exercises);  // Return the exercises for the selected category
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

// Mark an exercise as done
router.put('/exercise/:exerciseId/done', async (req, res) => {
    try {
        const token = req.headers['authorization']?.split(' ')[1];
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userId = decoded.id;

        const { categoryId } = req.body;  // Category of the exercise
        const userProgress = await UserWorkoutProgress.findOne({ userId, category: categoryId });

        if (!userProgress) {
            // Create a new progress record if user hasn't started this category
            const newProgress = new UserWorkoutProgress({
                userId,
                category: categoryId,
                exercises: [{ exerciseId: req.params.exerciseId, isDone: true }]
            });
            await newProgress.save();
        } else {
            // Update the progress for the category
            const exercise = userProgress.exercises.find(e => e.exerciseId == req.params.exerciseId);
            if (exercise) {
                exercise.isDone = true;
            } else {
                userProgress.exercises.push({ exerciseId: req.params.exerciseId, isDone: true });
            }
            await userProgress.save();
        }

        res.json({ message: 'Exercise marked as done' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

module.exports = router;
