const jwt = require('jsonwebtoken');

// Middleware to verify JWT
const authenticateJWT = (req, res, next) => {
    const token = req.headers['authorization']?.split(' ')[1]; // Get token from the Authorization header

    if (!token) {
        return res.status(403).json({ message: 'Access denied, token missing!' });
    }

    // Verify token
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            return res.status(403).json({ message: 'Invalid token!' });
        }

        // Save user info in request for use in other routes
        req.user = user;
        next(); // Proceed to the next middleware or route handler
    });
};

module.exports = authenticateJWT;
