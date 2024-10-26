const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema({
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true
    },
    workoutName: {
        type: String,  // Store the name of the workout (e.g., Full Body Exercise, Lower Body Exercise)
        required: true,
        enum: ['Full Body Exercise', 'Lower Body Exercise', 'AB Workout'],  // List of available workout names
    },
    time: {
        type: String,  // Time in HH:mm or 24-hour format
        required: true
    },
    isEnabled: {
        type: Boolean,
        default: true
    }
}, { timestamps: true });

const Notification = mongoose.model('Notification', notificationSchema);

module.exports = Notification;
