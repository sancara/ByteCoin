//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Santiago Caraballo on 18/04/2022.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    
    let rate: Double
    let asset_id_quote: String
    
    var rateToString: String {
       return String(format: "%.1f", rate)
    }
}
