import Foundation

public class NetworkConnectionError : LocalizedError {
    var message: String
    
    init(message: String) {
        self.message = message
    }
    
    public var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }
}
