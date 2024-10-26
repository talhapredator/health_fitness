const express = require('express');
const jwt = require('jsonwebtoken');
const Profile = require('../models/Profile');
const calculateWaterIntake = require('../utils/waterIntakeCalculator'); // Import the water intake calculator

const router = express.Router();

// Middleware to authenticate the token and extract user ID
const authenticateToken = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1]; // Extract token from header

    if (!token) {
        return res.status(401).json({ message: 'No token provided' });
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
            return res.status(403).json({ message: 'Failed to authenticate token' });
        }
        req.userId = decoded.id; // Extract user ID from the token
        next();
    });
};

// Create or update user profile
router.post('/', async (req, res) => {
    const { gender, dateOfBirth, weight, height, goals} = req.body;

    try {
        // Extract userId from the JWT token
        const token = req.headers['authorization']?.split(' ')[1]; // Extract token
        const decoded = jwt.verify(token, process.env.JWT_SECRET); // Decode the token
        const userId = decoded.id; // Get the user ID from the decoded token

        // Find the profile by userId
        let profile = await Profile.findOne({ userId });

        let bmi = 0;
        if (weight && height) {
            const heightmeter = height / 100;
            bmi = weight / (heightmeter * 2);  // height should be in meters
        }

        const updatedWaterIntake = calculateWaterIntake();

        if (profile) {
            // Update existing profile
            profile.gender = gender;
            profile.dateOfBirth = dateOfBirth;
            profile.weight = weight;
            profile.height = height;
            profile.goals = goals;
            profile.bmi = bmi;
            profile.waterIntake = updatedWaterIntake; 

            await profile.save();
            return res.json({ message: 'Profile updated successfully', profile });
        }

        return res.status(404).json({ message: 'Profile not found' });

    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});


// Get user profile
router.get('/me', authenticateToken, async (req, res) => {
    const userId = req.userId; // Get userId from the token

    try {
        const profile = await Profile.findOne({ userId });

        if (!profile) {
            return res.status(404).json({ message: 'Profile not found' });
        }

        res.json(profile);
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

module.exports = router;
