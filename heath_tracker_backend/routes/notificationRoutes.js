const express = require('express');
const router = express.Router();
const Notification = require('../models/Notification');
const authenticateToken = require('../middleware/authenticateToken'); // import middleware

// Route to enable/disable notification
router.post('/toggle-notification', authenticateToken, async (req, res) => {
    const { workoutName, time, isEnabled } = req.body;
    const userId = req.userId; // Get userId from token

    try {
        let notification = await Notification.findOne({ userId, workoutName });

        if (!notification) {
            notification = new Notification({ userId, workoutName, time, isEnabled });
        } else {
            notification.isEnabled = isEnabled;
            notification.time = time;
        }

        await notification.save();
        res.status(200).json({ message: 'Notification preference updated successfully.' });
    } catch (error) {
        res.status(500).json({ message: 'Error updating notification.', error });
    }
});

module.exports = router;
