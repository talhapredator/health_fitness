// utils/waterIntakeCalculator.js

function calculateWaterIntake() {
    const currentHour = new Date().getHours(); // Get the current hour (0-23 format)

    let waterIntake = 0;

    if (currentHour >= 6 && currentHour < 9) {
        waterIntake = 16.2;
    } else if (currentHour >= 9 && currentHour < 11) {
        waterIntake = 39.7;
    } else if (currentHour >= 11 && currentHour < 14) {
        waterIntake = 66.7;
    } else if (currentHour >= 14 && currentHour < 16) {
        waterIntake = 85.6;
    } else if (currentHour >= 16) {
        waterIntake = 99.9;
    }

    return waterIntake;
}

module.exports = calculateWaterIntake;
