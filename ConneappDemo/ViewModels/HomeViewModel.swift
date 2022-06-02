

import Foundation
import UIKit

protocol APIResponseDelegate: AnyObject{
    
    func completedApiRequest()
    
    func showError()
    
    func statusAPIRequest()
}
class HomeViewModel {
    
    public weak var delegate: APIResponseDelegate?
    var isOnline: Bool = true
    let apiService: APIServiceProtocol
    
    private var weatherLists: [List] = [List]()
    var filterWeatherData: [WeatherListCellViewModel] = [WeatherListCellViewModel]()
    
    private var cellViewModels: [WeatherListCellViewModel] = [WeatherListCellViewModel]() {
        didSet {
            self.delegate?.completedApiRequest()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.delegate?.statusAPIRequest()
        }
    }
    func returnAlpha() -> CGFloat {
        return isLoading ? 0.0 : 1.0
    }
    var alertMessage: String? {
        didSet {
            self.delegate?.showError()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    var numberOfCollectionCell: Int {
        return cellViewModels.unique{ $0.date }.count
    }
    
    func populatedTableData(num: Int) {
        let getDates =  cellViewModels.unique{ $0.date }
        filterWeatherData.removeAll()
        filterWeatherData = cellViewModels.filter ({ $0.date == getDates[num].date })
    }
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func initFetch() {
        self.isLoading = true
        apiService.fetchTopStories(isOnline: isOnline) { [weak self] (success, results, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.localizedDescription
            } else {
                self?.processFetchedTopStories(weatherLists: results)
            }
        }
    }
    
    
    func createCellViewModel(weatherList: List ) -> WeatherListCellViewModel {
        
        let dateAndTime = weatherList.dt_txt?.components(separatedBy: " ")
        guard let date = dateAndTime?[0], let time = dateAndTime?[1] else { return WeatherListCellViewModel(temperature: 0.0, time: "", date: "", weatherIcon: "")}
        
        return WeatherListCellViewModel(temperature: weatherList.main?.temp ?? 0.0, time: time, date: date, weatherIcon: weatherList.weather?[0].icon ?? "")
    }
    
//    func getCellViewModel( at indexPath: IndexPath ) -> WeatherListCellViewModel {
//        return cellViewModels[indexPath.row]
//    }
    
    private func processFetchedTopStories( weatherLists: [List] ) {
        
        self.weatherLists = weatherLists // Cache
        var vms = [WeatherListCellViewModel]()
        for topStory in weatherLists {
            vms.append(createCellViewModel(weatherList: topStory))
        }
        self.cellViewModels = vms
    }
    
}

struct WeatherListCellViewModel {
    
    let temperature: Double
    let time: String
    let date: String
    let weatherIcon: String
}

