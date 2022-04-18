//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "3710E5A6-0335-4D32-839C-7090F1325CE8"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let currencyURL = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(currencyURL: currencyURL)
        
    }
    
    func performRequest(currencyURL: String) {
        if let url = URL(string: currencyURL) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    //                    delegate?.didFailWithError(self, error: error!)
                    print(error!)
                    return
                }
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8))
                    
                    //                    if let change = self.parseJSON(exchangeRate: safeData) {
                    //                        self.delegate?.didUpdateValue(self, exchangeRate: change)
                }
            }
            task.resume()
        }
    }
}




