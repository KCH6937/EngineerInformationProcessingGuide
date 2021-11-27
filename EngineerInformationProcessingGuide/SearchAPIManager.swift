import Foundation
import Alamofire
import SwiftyJSON

class SearchAPIManager {
    
    static let shared = SearchAPIManager() // singleton
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchLocationData(serviceid: String, query: String, display: String, start: String, sort: String, result: @escaping CompletionHandler) {
        
        let header: HTTPHeaders = [
            "X-Naver-Client-Id" : APIKey.NAVER_ID,
            "X-Naver-Client-Secret" : APIKey.NAVER_SECRET
        ]
        
        let parameters = [
            "query" : query,
            "display" : display,
            "start" : start,
            "sort" : sort
        ]
        
        AF.request(EndPoint.searchURL + serviceid, method: .get,  parameters: parameters, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //print("JSON: \(json)")
                
                let code = response.response?.statusCode ?? 500
       
                result(code, json)
                
            case .failure(let error):   // 네트워크 통신 자체가 실패
                print(error)    // 인터넷을 연결해주세요(alert 처리)
            }
        }
    }
}
