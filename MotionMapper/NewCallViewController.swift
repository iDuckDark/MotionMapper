import UIKit

class NewCallViewController: UIViewController {
  var handle: String? {
    return handleTextField.text
  }
  
  var incoming: Bool {
    return incomingSegmentedControl.selectedSegmentIndex == 0
  }
  
  var videoEnabled: Bool {
    return videoSwitch.isOn
  }
  
  @IBOutlet private var handleTextField: UITextField!
  @IBOutlet private var videoSwitch: UISwitch!
  @IBOutlet private var incomingSegmentedControl: UISegmentedControl!

  @IBAction private func cancel(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
}
