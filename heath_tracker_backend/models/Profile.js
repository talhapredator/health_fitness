// models/Profile.js

const mongoose = require('mongoose');

const profileSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
        unique: true
    },
    firstName: { type: String, required: true },
    gender: { type: String },
    dateOfBirth: { type: Date },
    weight: { type: Number },
    height: { type: Number },
    goals: { type: String },
    bmi: { 
        type: Number, 
        default: 0  // BMI value, calculated from weight and height
    },
    heartbeat: {
        type: Number,
        default: 0  // Heartbeat in beats per minute (BPM)
    },
    waterIntake: {
        type: Number,
        default: 0  // Water intake in liters
    },
    sleep: {
        type: Number,
        default: 0  // Sleep in hours
    },
    calories: {
        type: Number,
        default: 0  // Calories burned or consumed
    }
}, { timestamps: true });

const Profile = mongoose.model('Profile', profileSchema, 'profiles');

module.exports = Profile;
