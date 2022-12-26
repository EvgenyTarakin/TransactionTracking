//
//  NetworkService.swift
//  TransactionTracking
//
//  Created by Евгений Таракин on 25.12.2022.
//

import Foundation

class NetworkService {
    
    static let urlsession = URLSession(configuration: .default)
    
    static func getNewBitcoinCourse(complition: @escaping(String) -> ()) {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else { return }
        NetworkService.urlsession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let bpi = json?["bpi"] as? [String: Any]
                guard let usd = bpi?["USD"] as? [String: Any] else { return }
                guard let resault = usd["rate"] as? String else { return }
                complition(resault)
            } catch {
                print(error)
            }
        }.resume()
    }
}
