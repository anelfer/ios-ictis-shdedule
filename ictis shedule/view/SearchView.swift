//
//  SearchView.swift
//  ictis shedule
//
//  Created by Alexander Rafshnayder on 30.08.2023.
//

import SwiftUI

struct SearchView: View {
    @State private var searchResult = SearchResult(choices: [SearchGroup(name: "load", id: "load", group: "load")])
    @State private var searchText = ""
    @State var group = "55.html"
    
    var body: some View {
        NavigationStack {
                   List {
                       ForEach(searchResults, id: \.self) { name in
                           NavigationLink(destination: ScheduleView()) {
                               Text(name)
                           }.onSubmit {
                               group = "52.html"
                           }
                       }
                   }
                   .navigationTitle("Search group")
               }
        .navigationBarBackButtonHidden(true)
               .searchable(text: $searchText)
               .onAppear(perform: runSearch)
               .onSubmit(of: .search, runSearch)
               //.onChange(of: searchScope) { _ in runSearch() }
    }
    
    var searchResults: [String] {
            if searchText.isEmpty {
                return [searchResult.choices[0].group]
            } else {
                return searchResult.choices.map { $0.name }
            }
        }
    
    func runSearch() {
        Task {
            let url = URL(string: "https://ictis.ru/api.php?query=" + searchText)!
            let (data, _) = try await URLSession.shared.data(from: url)
            searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

struct SearchResult: Codable {
    let choices: [SearchGroup]
}

struct SearchGroup: Codable {
    let name: String
    let id: String
    let group: String
}
