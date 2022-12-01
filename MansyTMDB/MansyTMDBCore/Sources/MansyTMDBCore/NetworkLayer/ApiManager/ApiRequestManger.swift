import Foundation
import Alamofire
import Combine

public protocol ApiManagerProtocol {
    init(parser: ParserHandlerProtocol, errorHandler: ErrorHandlerProtocol)
    func apiCall<T: Codable>(endPoint: BaseEndPointProtocol) -> Future<T, Error>
}

public class ApiManager: ApiManagerProtocol {
    
    var parser: ParserHandlerProtocol = DefaultParser.init()
    var errorHandler: ErrorHandlerProtocol!
    
    public required init(parser: ParserHandlerProtocol, errorHandler: ErrorHandlerProtocol) {
        self.parser = parser
        self.errorHandler = errorHandler
    }
    
    public init() {
    }
    
    public func apiCall<T: Codable>(endPoint: BaseEndPointProtocol) -> Future<T,Error>  {
        let url = endPoint.url
        let parameters = endPoint.parameters
        let headers = HTTPHeaders.init(endPoint.headers)
        let method = HTTPMethod.init(rawValue: endPoint.httpMethod.rawValue)
        let encoding: ParameterEncoding = {
            switch endPoint.encoding{
            case .URL:
                return URLEncoding.default
            case .JSON:
                return JSONEncoding.default
            }
        }()

        return Future { promise in
            guard  NetworkMonitor.shared.isConnected else{
                    promise(.failure(NetworkConnectionError(message: "No internet connection")))
                return
            }
            _ = AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    #if DEBUG
                    let url = response.request?.url?.absoluteString
                    let string = String.init(data: data, encoding: .utf8)
                    print("=============== REQUEST - START ===============")
                    print("✅ parameters:  \(parameters ?? [:])")
                    print("✅ headers:  \(headers)")
                    print("✅ network isConnected:  \(NetworkMonitor.shared.isConnected)")
                    print("✅ URL:  \(url ?? "❌")")
                    print("✅ Response \(string ?? "❌")")
                    print("=============== REQUEST - END ===============")
                    #endif
                    let parserResult: Result<T,Error> = self.parser.ParserHandler(parsefrom: data)
                    switch parserResult {
                    case .success(let object):
                        promise(.success(object))
                    case .failure(let error):
                        promise(.failure(error))
                        #if DEBUG
                        print(" Parsing Fail: \(error)")
                        #endif
                    }
                    break
                case .failure(let error):
                    promise(.failure(error))
                    #if DEBUG
                    print(error)
                    #endif
                }
            }
        }
    }
}
