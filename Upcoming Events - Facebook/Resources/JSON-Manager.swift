//
//  JSON-Manager.swift
//  Upcoming Events - Facebook
//
//  Created by Kody Young on 8/12/21.
//

import Foundation

final class JSONManager {
    public static let shared = JSONManager()
    public static var path = URL(string: String())
}

extension JSONManager {
    public enum JSONManagerError: Error {
        case failedToFetch

        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "Failed to load data from mock.json"
            }
        }
    }

    func getPathForResource(){
        if let resourcePath = Bundle.main.url(forResource: "mock",withExtension: "json"){
            
            JSONManager.path = resourcePath
           
            JSONManager.shared.getDataFor(path: JSONManager.path!,
                                          completion: {  result in
                switch result {
                    case .success(let json):
                        DataProvider.eventList = json as! [EventModelItem]
                        JSONManager.shared.sortItems()
                        JSONManager.shared.groupItems()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            })
        }
    }
    
    public func getDataFor(path: URL, completion: @escaping (Result<Any, Error>) -> Void) {
  
        do {
            let decoderdec = JSONDecoder()
            decoderdec.keyDecodingStrategy = .convertFromSnakeCase
            let jsonData = try Data(contentsOf: path)
            let jsonResults = try decoderdec.decode([EventModelItem].self, from: jsonData)
            completion(.success(jsonResults))
        }
    
        catch {
            completion(.failure(JSONManagerError.failedToFetch))
        }
    }
    
    public func sortItems(){
         DataProvider.eventList.sort(by: { JSONManager.shared.dateStringFormatter(dateString: $0.start).compare(JSONManager.shared.dateStringFormatter(dateString: $1.start))
                                        == .orderedAscending })
    }
    
    public func groupItems() {
        EventProvider.groupedItems = Dictionary(grouping: DataProvider.eventList, by: { (element: EventModelItem) in
            let monthDate: String = element.start.components(separatedBy: ",")[0]
            return monthDate
        })
    }
    
    public func dateStringFormatter(dateString: String) -> Date{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy h:mm a"
        let date = dateFormatter.date (from: dateString) ?? Date()
        return date
    }
}
