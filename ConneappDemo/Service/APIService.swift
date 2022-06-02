

import Foundation

protocol APIServiceProtocol {
    func fetchTopStories(isOnline: Bool, complete: @escaping ( _ success: Bool, _ topStories: [List], _ error: Error? )->() )
}
enum WebAPI {
    static let iconUrl = "http://openweathermap.org/img/wn/"
}
enum Constant {
    static let queryPath = "Belgrade"
    static let baseUrlString = "https://api.openweathermap.org/data/2.5/forecast?q="
    static let apiKey = "6efff1ec6a95175c7b0b2970a5c1ebea"
}

class UrlComponents {
    let path: String
    var url: URL {
        var query = [String]()
        query.append("appid=\(Constant.apiKey)")
        
        let url = URL(string: String(format: "%@%@&appid=%@", Constant.baseUrlString,Constant.queryPath,Constant.apiKey))
        return url!
    }
    
    init(path: String) {
        self.path = path
    }
}

private let sessionManager: URLSession = {
    let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
    return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
}()

class APIService: APIServiceProtocol {
    // Simulate a long waiting for fetching
    func fetchTopStories(isOnline: Bool, complete: @escaping ( _ success: Bool, _ results: [List], _ error: Error? )->() ) {
        
        if isOnline {
        let urlComponents = UrlComponents(path: Constant.queryPath)
        let request = URLRequest(url: urlComponents.url)
        sessionManager.dataTask(with: request) { (data, response, error) in
            
            //Handle error case
            guard error == nil else {
                complete( false,[], error )
                
                return
            }
            guard let data = data else {
                return
            }
            let resultItem = self.handelData(data: data)
            if resultItem.count > 0 {
                complete( true, resultItem, nil )
            } else {
                complete(false, [], nil)
            }
        }.resume()
        } else {
            let data = self.readjson(fileName: "LocalData")
            let resultItem = handelData(data: data)
            if resultItem.count > 0 {
                complete( true, resultItem, nil )
            } else {
                complete(false, [], nil)
            }

        }
    }
    
    func handelData(data: Data) -> [List] {
        let response = try? JSONDecoder().decode(WeatherInformation.self, from: data)
        if(response?.cod == "200") {
            if let resultsItem = response?.list {
                return resultsItem
            }
        }
        return []
    }
    
    func readjson(fileName: String) -> Data{

        var dataPath: Data!

         if let path : String = Bundle.main.path(forResource: fileName, ofType: "json") {
             if let data = NSData(contentsOfFile: path) {
                 dataPath =  data as Data
             }
         }
         return dataPath
    }
    
}
