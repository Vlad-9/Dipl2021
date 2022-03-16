import Foundation
import Alamofire

class ServerModule {

    var baseURL: URL {
        return API.baseUrl
    }

    let defaults = UserDefaults.standard
    var userInfo: [[String:Any]] = []
    let params = ["sum": 0.0]

    func loadUserInfoFromAPI(completionHandler :@escaping ([[String:Any]]?) -> Void) {

        let headers = API.bearerHeaders()
        request("\(API.baseUrl)/users/", method: .get, headers: headers).responseJSON {
            response in

            let value = response.result.value as? [[String: AnyObject]]

            completionHandler(value!)
        }
    }

    func loadTransactionInfoFromAPI(completionHandler :@escaping ([[String:Any]]?) -> Void) {

        let headers = API.bearerHeaders()

        request("\(API.baseUrl)/transactions/", method: .get, headers: headers).responseJSON{ [self]
            response in

            var value = response.result.value as? [[String: AnyObject]]

            value!.reverse()
            completionHandler(value!)
        }
    }

    func loadAvBenInfoFromAPI(completionHandler :@escaping ([[String:Any]]?) -> Void) {


        let headers = API.bearerHeaders()
        
        request("\(API.baseUrl)/benefits/search", method: .get, headers: headers).responseJSON {
            response in

            let value = response.result.value as? [[String: AnyObject]]

            completionHandler(value!)
        }
    }

    func loadUsBenInfoFromAPI(completionHandler :@escaping ([[String:Any]]?) -> Void) {

        //var headers = authModule.loadToken()
        let headers = API.bearerHeaders()

        request("\(API.baseUrl)/usbenefits/", method: .get, headers: headers).responseJSON{
            response in
            var m: [[String: Any]]
            let value = response.result.value as? [[String: AnyObject]]
            m = value!
            m.reverse()
            completionHandler(m)

        }
    }

    func postNewUsBenToAPI(benefitId: String) {

        let paramss = ["sum": 0.0,]
        let headers = API.bearerHeaders()

        request("\(API.baseUrl)/transactions/\(benefitId)", method: .put,parameters: paramss, headers: headers)
        
    }

    func loadBenefitInfoFromAPI(benefitId: Int, completionHandler :@escaping ([String:Any]?) -> Void) {

        let headers = API.bearerHeaders()

        request("\(API.baseUrl)/benefits/\(benefitId)", method: .get, headers: headers).responseJSON{
            response in

            var m: [String: Any]
            let value = response.result.value as? [String: AnyObject]
            m = value!

            completionHandler(m)

        }
    }

    func postNewBenefitFeedbackToAPI(params: [String:Any],benId: Int,completionHandler :@escaping ([String:Any]?) -> Void) {

        let headers = API.bearerHeaders()

        Alamofire.request("http://localhost:8080/api/benefits/rate/\(benId)", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            .responseJSON  {

                response in

                let value = response.result.value as? [String: AnyObject]

                completionHandler(value!)
            }
        }
    }
