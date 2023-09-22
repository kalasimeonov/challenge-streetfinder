//
//  StreetListings.swift
//  StreetFinder
//
//  Created by Evelina Zaneva on 22.09.23.
//

import Foundation

// MARK: - StreetListings
struct StreetListings: Codable {
    let type, version: String
    let features: [Feature]
    let attribution, licence, query: String
    let filters: Filters
    let limit: Int
}

// MARK: - Feature
struct Feature: Codable {
    let type: String
    let geometry: Geometry
    let properties: Properties
}

// MARK: - Geometry
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}

// MARK: - Properties
struct Properties: Codable {
    let label: String
    let score: Double
    let housenumber, id, name, postcode: String
    let citycode: String
    let x, y: Double
    let city: String
    let district: String?
    let context, type: String
    let importance: Double
    let street: String
}

// MARK: - Filters
struct Filters: Codable {
    let type: String
}
