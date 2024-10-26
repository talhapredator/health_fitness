const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const Profile = require('../models/Profile');

const router = express.Router();

// In-memory token blacklist (for demonstration purposes)
const tokenBlacklist = [];

// SIGN UP route
router.post('/signup', async (req, res) => {
    const { firstName, lastName, email, password } = req.body;

    try {
        // Check if user exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: 'User already exists' });
        }

        // Hash the password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // Create a new user
        const newUser = new User({
            firstName,
            lastName,
            email,
            password: hashedPassword
        });

        await newUser.save();

        // Create a profile for the user
        const profile = new Profile({
            userId: newUser._id,
            firstName, // Adding firstName to the profile
        });

        await profile.save();

        // Return success message
        res.status(201).json({ message: 'User registered successfully', profile });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

router.post('/login', async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'Invalid email or password' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid email or password' });
        }

        // Generate JWT token
        const token = jwt.sign(
            { id: user._id, email: user.email }, // user ID is included in the token payload
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );

        // Return the token
        res.json({ token, message: 'Login successful' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

// LOGOUT route
router.post('/logout', (req, res) => {
    const token = req.headers['authorization']?.split(' ')[1]; // Get token from headers

    if (token) {
        // Add token to blacklist
        tokenBlacklist.push(token);
        res.json({ message: 'Logout successful' });
    } else {
        res.status(400).json({ message: 'No token provided' });
    }
});

router.delete('/deleteUser', async (req, res) => {
    const { email, userId } = req.body;

    try {
        let user;

        // Find the user either by email or by userId
        if (email) {
            user = await User.findOne({ email });
        } else if (userId) {
            user = await User.findById(userId);
        } else {
            return res.status(400).json({ message: 'Please provide either an email or userId' });
        }

        // If user is not found
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }

        // Delete the user's profile
        await Profile.findOneAndDelete({ userId: user._id });

        // Delete the user
        await User.findByIdAndDelete(user._id);

        res.status(200).json({ message: 'User and associated profile deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: 'Server error', error });
    }
});

// Middleware to check if token is blacklisted
const isTokenBlacklisted = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1];
    if (token && tokenBlacklist.includes(token)) {
        return res.status(401).json({ message: 'Token is blacklisted. Please login again.' });
    }
    next();
};

// Example protected route
router.get('/protected', isTokenBlacklisted, (req, res) => {
    res.json({ message: 'You have accessed a protected route!' });
});

module.exports = router;
