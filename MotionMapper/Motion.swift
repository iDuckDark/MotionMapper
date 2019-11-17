/// Copyright (c) iDarkDuck. All rights reserved.
	

import Foundation
import CoreMotion
import CoreLocation

class Motion: NSObject {
    
    var motion = CMMotionManager()
    let locationManager = CLLocationManager()
    var updateFrequency: Double = 0.5
    
    var deviceFile = MotionFileManager(filename: "device.txt")
    var gyroFile = MotionFileManager(filename: "gyro.txt")
    var accelerometerFile = MotionFileManager(filename: "accelerometer.txt")
    var locationFile = MotionFileManager(filename: "location.txt")

    override init() {
        print("Init Motion")
    }
    
    init(updateFrequency: Double) {
        print("init Motion with update frequency", updateFrequency)
    }
    
    func startMotion(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.myDeviceMotion()
        self.myGyroscope()
        self.myAccelerometer()
    }
    
    func stopMotion(){
        locationManager.stopUpdatingLocation()
        motion.stopDeviceMotionUpdates()
        motion.stopGyroUpdates()
        motion.stopAccelerometerUpdates()
    }
    
    func clearFiles(){
        self.deviceFile.clearFile()
        self.gyroFile.clearFile()
        self.accelerometerFile.clearFile()
        self.locationFile.clearFile()
    }
        
    func getLogs() -> Dictionary<String, String> {
        let deviceLogs = self.deviceFile.readFile()
        let gyroLogs = self.gyroFile.readFile()
        let accelerometerLogs = self.accelerometerFile.readFile()
        let locationLogs = self.locationFile.readFile()
        var retval = Dictionary<String, String>()
        retval["device"] = deviceLogs
        retval["gyro"] = gyroLogs
        retval["accelerometer"] = accelerometerLogs
        retval["location"] = locationLogs
        return retval
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let trueData: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(trueData.latitude) \(trueData.longitude)")
        let string = "location= Latitude: \(trueData.latitude) , Longtitude\(trueData.longitude)"
        self.locationFile.writeToFile(string: string)
    }
    
    func myDeviceLocations(){
        print("Start DeviceLocations")
        motion.gyroUpdateInterval = self.updateFrequency
        motion.startGyroUpdates(to: OperationQueue.current!) {
            (data, error) in
//            print(data as Any)
            if let trueData =  data {
                let x = trueData.rotationRate.x
                let y = trueData.rotationRate.y
                let string = "Rotation= Latitude: \(x) , Longtitude\(y)"
                self.locationFile.writeToFile(string: string)
                let current = self.locationFile.readFile()
                print("Line 80 ", current)
            }
        }
        return
    }
    
    
    func myDeviceMotion(){
        print("Start DeviceMotion")
        motion.deviceMotionUpdateInterval  = self.updateFrequency
        motion.startDeviceMotionUpdates(to: OperationQueue.current!) {
            (data, error) in
//            print(data as Any)
            if let trueData =  data {
                let x = trueData.attitude.pitch
                let y = trueData.attitude.roll
                let z = trueData.attitude.yaw
                
                let textX = "x (pitch): \(x)"
                let textY = "y (roll): \(y)"
                let textZ = "z (yaw): \(z)"
                
                let string = "Device Motion= \(textX), \(textY), \(textZ) "
                self.deviceFile.writeToFile(string: string)
            }
        }
        return
    }
    
    
    func myGyroscope(){
        print("Start Gyroscope")
        motion.gyroUpdateInterval = self.updateFrequency
        motion.startGyroUpdates(to: OperationQueue.current!) {
            (data, error) in
//            print(data as Any)
            if let trueData =  data {
                let x = trueData.rotationRate.x
                let y = trueData.rotationRate.y
                let z = trueData.rotationRate.z
                let string = "Gyro= X: \(x) , Y: \(y), Z: \(z)"
                self.gyroFile.writeToFile(string: string)
            }
        }
        return
    }
    
    
    func myAccelerometer() {
        print("Start Accelerometer")
        motion.accelerometerUpdateInterval = self.updateFrequency
        motion.startAccelerometerUpdates(to: OperationQueue.current!) {
            (data, error) in
//            print(data as Any)
            if let trueData =  data {
                let x = "X: \(trueData.acceleration.x)"
                let y = "Y: \(trueData.acceleration.y)"
                let z = "Z: \(trueData.acceleration.z)"
                let string = "Accelerometer= X: \(x) , Y: \(y), Z: \(z)"
                self.accelerometerFile.writeToFile(string: string)
            }
        }
        return
    }
}
