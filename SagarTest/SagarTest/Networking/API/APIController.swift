

import Moya
import Result
import Foundation
typealias JSONDictionary = [String: Any]

enum ResponseCode : String{
    case Success = "200"
    case Created = "201"
    case AlreadyExist = "400"
    case Failed = "error"
    case Unauthorised = "401"
    case Block_by_admin = "403"
    case Unverify_by_admin = "419"
    case  Invalid = "404"
}

class APIController {
    public typealias CompletionHandler = (_ result: Result<Moya.Response, EBabuError>) -> Void
    private class func callService(request: EBabuAPI, completionHandler: @escaping CompletionHandler) {
        EBabuAPIProvider.request(request) { (result) in
            switch result {
            case let .success(response):
                if !Helpers.validateResponse(response.statusCode) {
                    guard let json = try? response.mapJSON() as? JSONDictionary else {
                        completionHandler(Result.failure(EBabuError.failure(Constants.Texts.errorParsingResponse)))
                        return
                    }
                    let error = EBabuError.init(json)
                    completionHandler(Result.failure(error))
                    return
                }
                completionHandler(Result.success(response))
            case .failure(_):
                completionHandler(Result.failure(EBabuError.noConnectivity()))
            }
        }
    }
    public class func makeRequest(_ request: EBabuAPI, completion:@escaping ((Data?, EBabuError?) -> Void)) {
        APIController.callService(request: request) { (result) in
            switch result {
            case .success(let response):
                completion(response.data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    public class func makeRequestReturnJSON(_ request: EBabuAPI, completion:@escaping ((JSONDictionary?,Int, EBabuError?) -> Void)) {
        APIController.callService(request: request) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    guard let json = try? response.mapJSON() as? JSONDictionary else {
                        print(response.statusCode)
                        completion(nil,response.statusCode ,EBabuError.unknownError())
                        return
                    }
                    if let httpResponse = response.response {
                        if let xDemAuth = httpResponse.allHeaderFields["Authorization"] as? String {
                            print(xDemAuth)
                            Helpers.saveUserToken(token: xDemAuth)
                        }
                    }
                    completion(json,response.statusCode,nil)
                case .failure(let error):
                    completion(nil,0,error)
                }
            }
            
        }
    }
    
    public class func validateJason(_ code: String , completion:@escaping ((Bool) -> Void)) {
        
        switch code
        {
        case ResponseCode.Success.rawValue :
            completion(true)
            break
        case ResponseCode.Failed.rawValue :
            completion(false)
            break
        case ResponseCode.Unauthorised.rawValue :
            completion(false)
            break
        case ResponseCode.Unverify_by_admin.rawValue :
            completion(false)
            break
        case ResponseCode.Block_by_admin.rawValue :
            completion(false)
            break
        case ResponseCode.Created.rawValue:
            completion(true)
            break
        case ResponseCode.AlreadyExist.rawValue:
            completion(false)
            break
        default:
            completion(false)
            break
        }
    }
    
}
