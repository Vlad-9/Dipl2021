import Foundation
import Alamofire

class AuthModule {

    let defaults = UserDefaults.standard
    var userInfo: [[String:Any]] = []
    
    var baseURL: URL {
        return API.baseUrl.appendingPathComponent("auth")
    }

    func saveToken (token: String){

        self.defaults.set(token, forKey: "Token")
    }

    func loginWithAPI(userString: String, completionHandler :@escaping ([String:Any]?) -> Void) {
print ("func loaded")
        var headers = ["Authorization": "Basic 123"]
        headers.updateValue("Basic \(userString)", forKey: "Authorization")

        request("\(baseURL)/login", method: .post, headers: headers).responseJSON{ //[self]
            response in
            var m: [String: Any]
            let value = response.result.value as? [String: AnyObject]
            m = value!
            completionHandler(m)
        }
    }

    func registrationWithAPI(userParams: [String:Any], completionHandler :@escaping ([String:Any]?) -> Void) {

        request("\(baseURL)/register", method: .post, parameters: userParams).responseJSON{
            response in

            var m: [String: Any]
            let value = response.result.value as? [String: AnyObject]
            m = value!
            completionHandler(m)
        }
    }
}
