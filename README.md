# MotionMapper
Motion Mapper for mobile devices

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://nodesource.com/products/nsolid)
[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)

# Swift 5, Xcode 11 
### Core libraries used:
1. CoreMotion
2. CoreLocation
3. MapKit
4. Timer
5. FileManager

# Further Consideratiions
1. If we wanted to collect data samples of this movement from one million unique devices running our app in the future, what would be the best way to transfer the data from those devices to our Data Science team? 

    - Store the data into the database 
    - Consider having a time-series database if there is too many data
    - Make sure the logs are saved into a CSV Format with column headings/titles to make it easier for machine learning or data visualization
    - Find a suitable update frequency rate for the motion to prevent too many logs. For example every 5 seconds instead of 0.5 seconds

2. Since we are concerned about data privacy, what could we do to ensure that the data transfer is secure?

    - Prompt for User's permissions
    - End to end encryption when transfering logs to the server or database
    - User authentication
    - Filter sensitive data (name, phone number etc)

3. Is there anything you would have wanted to implement or improve in your code if you had more time?

    - Separate 1st level: logs by each call
    - Separate 2nd level logs into categories (DeviceMotion, Gyro, Accelerometer, Location)
    - Send the logs to the server / Email

4. Describe any issues you had while working on this challenge. 

    - Had some issues storing the files locally but the temp fix was to add a delete button to clear the previous logs which took up most of the time


