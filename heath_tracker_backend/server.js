const express = require('express');
const mongoose = require('mongoose');
const dotenv = require('dotenv');
const cron = require('node-cron');
const userRoutes = require('./routes/userRoutes');
const profileRoutes = require('./routes/profileRoutes');
const workoutController = require('./controllers/workoutController');
const workoutRoutes = require('./routes/workoutRoutes');
const dashboardRoutes = require('./routes/dashboardRoutes');
const notificationRoutes = require('./routes/notificationRoutes');
const Notification = require('./models/Notification');

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(express.json());

// Routes
app.use('/api/users', userRoutes);
app.use('/api/dash', dashboardRoutes);
app.use('/api/profile', profileRoutes); 
app.use('/api', workoutRoutes);
app.use('/api', notificationRoutes);

// MongoDB connection
mongoose.connect(process.env.MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connected'))

.catch(err => console.log(err));

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});

const sendNotification = (userId, workoutName) => {
    // Logic to send notification (e.g., email, SMS, or local push)
    console.log(`Sending notification to User: ${userId} for Workout: ${workoutName}`);
};

// Schedule notifications to run every minute and check who needs to be notified
cron.schedule('* * * * *', async () => {
    const now = new Date();
    const hours = now.getHours();
    const minutes = now.getMinutes();
    const time = `${hours}:${minutes}`;

    try {
        // Fetch users who have notifications enabled at the current time
        const notifications = await Notification.find({ time, isEnabled: true });

        notifications.forEach(notification => {
            // Call the function to send notification using workoutName instead of workoutId
            sendNotification(notification.userId, notification.workoutName);
        });
    } catch (error) {
        console.error('Error fetching notifications:', error);
    }
});