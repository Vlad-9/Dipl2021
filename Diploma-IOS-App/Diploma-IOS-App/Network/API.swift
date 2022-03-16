import Foundation

struct API {

    static var baseUrl: URL {
        return URL(string: "http://localhost:8080/api")!
    }

    static var baseHeaders: [String: String] {
        return ["Content-type": "application/json"]
    }

    static func basicHeaders(email: String, password: String) -> [String: String] {
        var headers = baseHeaders
        let basic = "\(email):\(password)"
        let loginData = basic.data(using: String.Encoding.utf8)!
        headers["Authorization"] = "Basic \(loginData.base64EncodedString())"
        return headers
    }

    static func bearerHeaders() -> [String: String] {
        let defaults = UserDefaults.standard
        let token = String(defaults.string(forKey: "Token")!)
        var headers = baseHeaders
        headers["Authorization"] = "Bearer \(token)"
        return headers
    }
}
