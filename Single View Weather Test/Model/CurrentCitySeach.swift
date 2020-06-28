//
//  CurrentCitySeach.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 27/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import Foundation

struct CurrentCitySearch: Codable {
    let cities: [Prediction]
    
    init? (currentCitySearch: CitySearchText) {
        cities = currentCitySearch.predictions
    }
}
