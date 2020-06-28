//
//  CitySearchTextData.swift
//  Single View Weather Test
//
//  Created by Станислав Белоусов on 27/06/2020.
//  Copyright © 2020 Станислав Белоусов. All rights reserved.
//

import Foundation

// MARK: - CitySearchText
struct CitySearchText: Codable {
    let predictions: [Prediction]
    let status: String
}

// MARK: - Prediction
struct Prediction: Codable {
    let predictionDescription: String
    let id: String
    let matchedSubstrings: [MatchedSubstring]
    let placeID: String
    let reference: String
    let structuredFormatting: StructuredFormatting
    let terms: [Term]
    let types: [String]

    enum CodingKeys: String, CodingKey {
        case predictionDescription = "description"
        case id
        case matchedSubstrings = "matched_substrings"
        case placeID = "place_id"
        case reference
        case structuredFormatting = "structured_formatting"
        case terms, types
    }
}

// MARK: - MatchedSubstring
struct MatchedSubstring: Codable {
    let length, offset: Int
}

// MARK: - StructuredFormatting
struct StructuredFormatting: Codable {
    let mainText: String
    let mainTextMatchedSubstrings: [MatchedSubstring]
    let secondaryText: String

    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case mainTextMatchedSubstrings = "main_text_matched_substrings"
        case secondaryText = "secondary_text"
    }
}

// MARK: - Term
struct Term: Codable {
    let offset: Int
    let value: String
}
