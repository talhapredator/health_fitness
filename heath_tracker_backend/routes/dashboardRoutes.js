// routes/dashboardRoutes.js

const express = require('express');
const Profile = require('../models/Profile');
const jwt = require('jsonwebtoken');

const router = express.Router();

// Dashboard route to fetch logged-in user data
router.get('/', async (req, res) => {
    try {
        const token = req.headers['authorization']?.split(' ')[1];

        if (!token) {
            return res.status(401).json({ message: 'No token provided' });
        }

        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userId = decoded.id;

        const profile = await Profile.findOne({ userId });

        if (!profile) {
            return res.status(404).json({ message: 'Profile not found' });
        }

        res.json({
            firstName: profile.firstName,
            lastName: profile.lastName,
            heartbeat: profile.heartbeat,
            waterIntake: profile.waterIntake,
            sleep: profile.sleep,
            calories: profile.calories
        });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

// Update user's metrics
router.post('/update-metrics', async (req, res) => {
    const { heartbeat, waterIntake, sleep, calories } = req.body;

    try {
        const token = req.headers['authorization']?.split(' ')[1];

        if (!token) {
            return res.status(401).json({ message: 'No token provided' });
        }

        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const userId = decoded.id;

        let profile = await Profile.findOne({ userId });

        if (!profile) {
            return res.status(404).json({ message: 'Profile not found' });
        }

        // Update profile metrics
        profile.heartbeat = heartbeat || profile.heartbeat;
        profile.waterIntake = waterIntake || profile.waterIntake;
        profile.sleep = sleep || profile.sleep;
        profile.calories = calories || profile.calories;

        await profile.save();

        res.json({ message: 'Metrics updated successfully', profile });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

module.exports = router;
