//
//  ScheduleView.swift
//  ictis shedule
//
//  Created by Alexander Rafshnayder on 30.08.2023.
//

import SwiftUI

struct ScheduleView: View {
    private let colors: [Color] = [.red, .blue]
    @State var dataInfo = Wrapper(table: Table(type: "testtype", name: "testname", week: 1, group: "testgroup", table: [["","","","","","","",""],
                                    ["","","","","","","",""],
                                    ["","","","","","","",""],
                                    ["","","","","","","",""],
                                                                                                                        ["","","","","","","",""],["","","","","","","",""],["","","","","","","",""],["","","","","","","",""]], link: "test"), weeks: [1, 2])
    @State var selectedWeek = 1
    @State var isLoadingWeek = false
    
    var body: some View {
        VStack() {
            HStack() {
                Spacer()
            }
            
            TabView {
                ForEach(2...7, id: \.self) { week in
                    ZStack {
                        VStack {
                            let table = dataInfo.table
                            Text(table.name + " " + table.table[week][0])
                            
                            ForEach(1...7,
                                    id: \.self) { pair in
                                LabeledContent(pair.description) {
                                    Text(table.table[week][pair])
                                }.padding(.horizontal, 55.0)
                            }
                        }
                    }
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Spacer()
            
            HStack(
                alignment: .bottom
            ) {
                Picker(selection: $selectedWeek, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/) {
                    ForEach(1...30,
                            id: \.self) {
                        Text("Week \($0)").tag($0)

                    }
                }.onChange(of: selectedWeek) { _ in
                    Task {
                        do {
                            isLoadingWeek = true
                            dataInfo = try await loadShedule(week: selectedWeek.description)
                            isLoadingWeek = false
                            print(dataInfo)
                        } catch let e {
                            print("EROR BLYAT " + String(describing: e))
                            dataInfo.table.name = "ERROR WHILE LOADING"
                            isLoadingWeek = false
                        }
                    }
                }
                
                if isLoadingWeek {
                    ProgressView()
                          .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                          .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                              // Simulates a delay in content loading
                              // Perform transition to the next view here
                            }
                          }
                }
            }
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}

func loadShedule(week: String) async throws -> Wrapper {
    print("attemptLoad!")
    let url = URL(string: "https://ictis.ru/api?request=schedule&group=55.html&week=" + week)!
    let (data, _) = try await URLSession.shared.data(from: url)
    let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
    return wrapper
}

struct Wrapper: Codable {
    var table: Table
    let weeks: [Int]
}

struct Table: Codable {
    let type: String
    var name: String
    let week: Int
    let group: String
    let table: [[String]]
    let link: String
}
