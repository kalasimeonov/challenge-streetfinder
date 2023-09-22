//
//  SearchScreenViewModel.swift
//  StreetFinder
//
//  Created by Evelina Zaneva on 22.09.23.
//

import Foundation

class SearchScreenViewModel: ObservableObject {
    
    @Published var searchQuery: String = ""
    @Published var listings: StreetListings?
    
    func fetchSearchData(query: String) async {
        let formattedQuery = query.replacingOccurrences(of: ",", with: "")
        let urlString = "https://api-adresse.data.gouv.fr/search/?q=\(formattedQuery)&type=housenumber"
        let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: encodedUrlString) else {
            print("Missing url")
            return
        }
        
        do {
            let request = try await URLSession.shared.data(from: url)
            let data = request.0
            let listings = try JSONDecoder().decode(StreetListings.self, from: data)
            DispatchQueue.main.async {
                self.listings = listings
            }
        } catch {
            print("Couldn't fetch data")
        }
    }
}
