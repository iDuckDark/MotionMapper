import Foundation
import CallKit

class CallManager {
  var callsChangedHandler: (() -> Void)?
  private let callController = CXCallController()
  
  private(set) var calls: [Call] = []
  
  func callWithUUID(uuid: UUID) -> Call? {
    guard let index = calls.firstIndex(where: { $0.uuid == uuid }) else {
      return nil
    }
    return calls[index]
  }
  
  func add(call: Call) {
    calls.append(call)
    call.stateChanged = { [weak self] in
      guard let self = self else { return }
      self.callsChangedHandler?()
    }
    callsChangedHandler?()
  }
  
  func remove(call: Call) {
    guard let index = calls.firstIndex(where: { $0 === call }) else { return }
    calls.remove(at: index)
    callsChangedHandler?()
  }
  
  func removeAllCalls() {
    calls.removeAll()
    callsChangedHandler?()
  }
  
  func end(call: Call) {
    let endCallAction = CXEndCallAction(call: call.uuid)
    let transaction = CXTransaction(action: endCallAction)
    
    requestTransaction(transaction)
  }
  
  private func requestTransaction(_ transaction: CXTransaction) {
    callController.request(transaction) { error in
      if let error = error {
        print("Error requesting transaction: \(error)")
      } else {
        print("Requested transaction successfully")
      }
    }
  }
  
  func setHeld(call: Call, onHold: Bool) {
    let setHeldCallAction = CXSetHeldCallAction(call: call.uuid, onHold: onHold)
    
    let transaction = CXTransaction()
    transaction.addAction(setHeldCallAction)
    
    requestTransaction(transaction)
  }
  
  func startCall(handle: String, videoEnabled: Bool) {
    let handle = CXHandle(type: .phoneNumber, value: handle)
    
    let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
    startCallAction.isVideo = videoEnabled
    
    let transaction = CXTransaction(action: startCallAction)
    
    requestTransaction(transaction)
  }
}
