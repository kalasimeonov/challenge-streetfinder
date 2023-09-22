//
//  SearchBar.swift
//  StreetFinder
//
//  Created by Evelina Zaneva on 22.09.23.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State private var isEditing = false

    var body: some View {
        HStack {
            TextField("", text: $text)
                .frame(height: 40)
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .padding(7)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .cornerRadius(6.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(Color(.gray), lineWidth: 1)
                    )
        }
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}

