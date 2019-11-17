import UIKit

class CallTableViewCell: UITableViewCell {
  var callState: CallState? {
    didSet {
      guard let callState = callState else { return }
      
      switch callState {
      case .active:
        callStatusLabel.text = "Active"
      case .held:
        callStatusLabel.text = "On Hold"
      case .connecting:
        callStatusLabel.text = "Connecting..."
      default:
        callStatusLabel.text = "Dialing..."
      }
    }
  }
  
  var incoming: Bool = false {
    didSet {
      iconImageView.image = incoming ? #imageLiteral(resourceName: "incoming_arrow") : #imageLiteral(resourceName: "outgoing_arrow")
    }
  }
  
  var callerHandle: String? {
    didSet {
      callerHandleLabel.text = callerHandle
    }
  }

  @IBOutlet private var iconImageView: UIImageView!
  @IBOutlet private var callerHandleLabel: UILabel!
  @IBOutlet private var callStatusLabel: UILabel!
}
