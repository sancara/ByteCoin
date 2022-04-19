//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didFailWithError (_ coinManager: CoinManager, error: Error)
    
    func didUpdateValue (_ coinManager: CoinManager, coinModel: CoinModel)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "3710E5A6-0335-4D32-839C-7090F1325CE8"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let currencyURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
    
        if let url = URL(string: currencyURL) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    delegate?.didFailWithError(self, error: error!)
                    return
                }
                if let safeData = data {
                   if let coinModel = parseJSON(safeData) {
                       self.delegate?.didUpdateValue(self, coinModel: coinModel)
                    }
                        
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice =  decodedData.rate
            let currency = decodedData.asset_id_quote
            
            return CoinModel(rate: lastPrice, asset_id_quote: currency)
        } catch {
            
            self.delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}




