import Foundation
import Alamofire
import SwiftyJSON

class TestLocationAPIManager {
    
    static let shared = TestLocationAPIManager() // singleton
    
    typealias CompletionHandler = (Int, JSON) -> ()
    
    func fetchLocationData(latitude: Double, longitude: Double, result: @escaping CompletionHandler) {
        
    }
}
