//
//  SearchView.swift
//  ictis shedule
//
//  Created by Alexander Rafshnayder on 30.08.2023.
//

import SwiftUI

struct SearchView: View {
    @State
    var searchStr: String = ""
    
    var body: some View {
        VStack() {
            TextField("You group or prepod", text: $searchStr)
                .border(.secondary)
                .padding()
            
            
            Spacer()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
