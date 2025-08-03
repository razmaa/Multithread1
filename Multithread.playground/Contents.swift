import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

func log(_ message: String) {
    let tid = Thread.isMainThread ? "🟢 main" : "⚪️ \(Thread.current)"
    print("\(message)   → \(tid)")
}


func makeOperation(named name: String) -> BlockOperation {
    return BlockOperation {
        log("Operation \"\(name)\" started")
        for _ in 0..<10_000 {
            _ = 1
        }
        log("Operation \"\(name)\" finished")
    }
}


let opOnMain = makeOperation(named: "A on main")
OperationQueue.main.addOperation(opOnMain)


final class QueueHolder {
    static let backgroundQueue: OperationQueue = {
        let q = OperationQueue()
        q.name = "com.example.backgroundQueue"
        q.maxConcurrentOperationCount = 1
        return q
    }()
}

let opOnBackground = makeOperation(named: "A on background")
QueueHolder.backgroundQueue.addOperation(opOnBackground)
