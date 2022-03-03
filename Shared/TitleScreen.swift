//
//  TitleScreen.swift
//  MICHAELMCGINNIS-Edutainment
//
//  Created by Michael Mcginnis on 3/2/22.
//

import SwiftUI

struct TitleScreen: View {
    @State private var difficulty = 2
    @State private var questionAmt = 10
    @State private var tableSet = 5
    var body: some View {
        NavigationView{
                VStack{
                    Spacer()
                    Text("Question Difficulty")
                    Picker("Question Difficulty", selection: $difficulty){
                        Text("Easy").tag(1)
                        Text("Medium").tag(2)
                        Text("Hard").tag(3)
                    }.pickerStyle(.segmented)
                    
                    Text("Question amount")
                    Picker("Question Amount", selection: $questionAmt){
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("20").tag(20)
                    }.pickerStyle(.segmented)
                    
                    Text("Table Size")
                    Picker("Table Size", selection: $tableSet){
                        Text("3 x 3").tag(3)
                        Text("5 x 5").tag(5)
                        Text("10 x 10").tag(10)
                    }.pickerStyle(.segmented)
                    Spacer()
                    NavigationLink(destination: ContentView(difficulty: difficulty, questionAmt: questionAmt, tableSet: tableSet)){
                    Text("Start game!")
                }
                    Spacer()
            }
                .navigationTitle("Settings")
        }
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreen()
    }
}
