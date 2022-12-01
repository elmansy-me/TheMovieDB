import Foundation

public protocol ParserHandlerProtocol {
    func ParserHandler<T: Codable>(parsefrom data:Data) -> Result<T,Error>
}

class DefaultParser: ParserHandlerProtocol {
    
    func ParserHandler<T: Codable>(parsefrom data:Data) -> Result<T,Error> {
        let decoder = JSONDecoder.init()
        do{
            let object = try decoder.decode(T.self, from: data)
            return .success(object)
        }
        catch{
            return .failure(error)
        }
    }
}
