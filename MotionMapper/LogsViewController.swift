/// Copyright (c) iDarkDuck. All rights reserved.
	

import UIKit

class LogsViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        scheduledTimerWithTimeInterval()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateText), userInfo: nil, repeats: true)
    }
    
    @objc func updateText(){
        let motion = myMotion.motion
        textView.text += motion.getLogs()["device"] ?? "Empty device logs"
        textView.text += motion.getLogs()["accelerometer"] ?? "Empty accelerometer logs"
        textView.text += motion.getLogs()["gyro"] ?? "Empty gyro logs"
        textView.text += motion.getLogs()["location"] ?? "Empty location logs"
    }

}
