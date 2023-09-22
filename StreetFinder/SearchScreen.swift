//
//  SearchScreen.swift
//  StreetFinder
//
//  Created by Evelina Zaneva on 22.09.23.
//

import SwiftUI
import MapKit

struct SearchScreen: View {
    
    @ObservedObject private var viewModel = SearchScreenViewModel()
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchQuery)
                .padding(.vertical)
            if let list = viewModel.listings?.features {
                    ForEach(list.indices, id: \.self) { index in
                        Text(list[index].properties.label)
                            .contentShape(Rectangle())
                            .frame(height: 20, alignment: .center)
                            .onTapGesture {
                                region.center.longitude = list[index].geometry.coordinates[0]
                                region.center.latitude = list[index].geometry.coordinates[1]
                            }
                    }
            }
            Spacer()
            Map(coordinateRegion: $region)
                .frame(height: 200, alignment: .center)
            Spacer()
        }
        .padding(.horizontal)
        .onReceive(viewModel.$searchQuery.debounce(for: 1.5, scheduler: RunLoop.main)) { query in
            Task {
                await viewModel.fetchSearchData(query: query)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
