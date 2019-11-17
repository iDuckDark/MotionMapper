import Foundation

enum CallState {
  case connecting
  case active
  case held
  case ended
}

enum ConnectedState {
  case pending
  case complete
}

class Call {
  let uuid: UUID
  let outgoing: Bool
  let handle: String
  
  var state: CallState = .ended {
    didSet {
      stateChanged?()
    }
  }
  
  var connectedState: ConnectedState = .pending {
    didSet {
      connectedStateChanged?()
    }
  }
  
  var stateChanged: (() -> Void)?
  var connectedStateChanged: (() -> Void)?
  
  init(uuid: UUID, outgoing: Bool = false, handle: String) {
    self.uuid = uuid
    self.outgoing = outgoing
    self.handle = handle
  }
  
  func start(completion: ((_ success: Bool) -> Void)?) {
    completion?(true)

    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.state = .connecting
      self.connectedState = .pending
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        self.state = .active
        self.connectedState = .complete
      }
    }
  }
  
  func answer() {
    state = .active
    print("Answer Call & Start Motion")
    myMotion.motion.startMotion()
  }
  
  func end() {
    state = .ended
    print("End Call & Stop Motion")
    myMotion.motion.stopMotion()
  }
}
