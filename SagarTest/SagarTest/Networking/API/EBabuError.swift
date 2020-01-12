

import Foundation
struct EBabuError: Swift.Error {
    let code: String
    let desc: String
    
    static func failure(_ text: String) -> EBabuError {
        return EBabuError.init(code: "", desc: text)
    }
    static func noConnectivity() -> EBabuError {
        return EBabuError.init(code: "", desc: "Please check your internet connection.")
    }
    static func unknownError() -> EBabuError {
        return EBabuError.init(code: "1000", desc: "Unknown Error")
    }
}
extension EBabuError {
    init(_ json: JSONDictionary) {
        self.code = json["code"] as? String ?? ""
        self.desc = json["error"] as? String ?? json["message"] as? String ?? ""
    }
}
