import Foundation

final class CallStation {
    var usersArray = [User]()
    var callsArray = [Call]()
}

extension CallStation: Station {
    func users() -> [User] {
        usersArray
    }
    
    func add(user: User) {
        if !usersArray.contains(user) {
            usersArray.append(user)
        }
    }
    
    func remove(user: User) {
        if let index = usersArray.firstIndex(of: user) {
            usersArray.remove(at: index)
        }
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(let from, let to):
            if !usersArray.contains(from) && !usersArray.contains(to) {
                return nil
            }
            var call = Call(id: UUID(), incomingUser: from, outgoingUser: to, status: .calling)
            if (calls(user: to).count > 0) {
                call.status = .ended(reason: .userBusy)
            } else if (!usersArray.contains(to)) {
                call.status = .ended(reason: .error)
            }
            callsArray.insert(call, at: 0)
            return call.id
        case .answer(let from):
            if let index = callsArray.firstIndex(where: {$0.outgoingUser == from}) {
                if !usersArray.contains(from) {
                    callsArray[index].status = .ended(reason: .error)
                    return nil
                }
                callsArray[index].status = .talk
                return callsArray[index].id
            }
        case .end(let from):
            if let index = callsArray.firstIndex(where: {$0.outgoingUser == from || $0.incomingUser == from}) {
                if (callsArray[index].status == .talk) {
                    callsArray[index].status = .ended(reason: .end)
                } else {
                    callsArray[index].status = .ended(reason: .cancel)
                }
                return callsArray[index].id
            }
        }
        return nil
    }
    
    func calls() -> [Call] {
        callsArray
    }
    
    func calls(user: User) -> [Call] {
        return callsArray.filter { $0.incomingUser == user || $0.outgoingUser == user }
    }
    
    func call(id: CallID) -> Call? {
        for call in callsArray {
            if call.id == id {
                return call
            }
        }
        return nil
    }
    
    func currentCall(user: User) -> Call? {
//        while true {
//            if let index = callsArray.firstIndex(where: {$0.status == .ended(reason: .end) || $0.status == .ended(reason: .cancel)}) {
//                callsArray.remove(at: index)
//            } else {
//                break
//            }
//        }
        for c in callsArray {
            if (c.incomingUser == user || c.outgoingUser == user) && (c.status == .calling || c.status == .talk){
                return c
            }
        }
        return nil
    }
}
