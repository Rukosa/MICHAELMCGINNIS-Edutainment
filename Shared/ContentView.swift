//
//  ContentView.swift
//  Shared
//
//  Created by Michael Mcginnis on 3/2/22.
//

import SwiftUI

struct ContentView: View {
    //Default Settings
    var difficulty: Int = 3
    var questionAmt: Int = 10
    var tableSet: Int = 10
    
    
    //View setup
        //Also used in hard difficulty
    let xNums = [1, 2, 3, 4 , 5, 6, 7, 8, 9, 10]
    let colors = [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.indigo, Color.purple, Color.cyan, Color.pink, Color.brown]
    
    let easy = [1, 2]
    let medium3 = [2 , 3]
    let medium5 = [1, 2, 3, 5]
    let medium10 = [1, 2, 3, 5, 10]
    //Game numbers
        //FIX 1...tableSet!!!
        //Difficulty should effect how numbers are generated
    @State private var randomNum: Int = 0
    @State private var randomNumTwo: Int = 0
    @State private var solution = 0
    
    func generateNums(){
        switch(difficulty){
        case 1: //easy
            randomNum = easy.randomElement() ?? 1
            randomNumTwo = easy.randomElement() ?? 1
        case 2: //medium
            if tableSet == 3{
                randomNum = medium3.randomElement() ?? 1
                randomNumTwo = medium3.randomElement() ?? 1
                return
            }
            if tableSet == 5{
                randomNum = medium5.randomElement() ?? 1
                randomNumTwo = medium5.randomElement() ?? 1
                return
            }
            if tableSet == 10{
                randomNum = medium10.randomElement() ?? 1
                randomNumTwo = medium10.randomElement() ?? 1
            }
        case 3: //hard
            randomNum = Int.random(in: 1...tableSet)
            randomNumTwo = Int.random(in: 1...tableSet)
        default: //should never reach
            randomNum = 1
            randomNumTwo = 1
        }
    }
    
    //Game functions
        //Checks if numbertapped is right
    func numberTapped(_ num: Int){
        solution = randomNum * randomNumTwo
        if(num == solution){
            scoreTitle = "Correct!"
            userScore += 1
            questionCounter += 1
        }
        else{
            scoreTitle = "Wrong!"
            questionCounter += 1
        }
        if(questionCounter == questionAmt){
            showingEndScore = true
        }
        else{
            showingScore = true
        }
    }
        //Asks another question
    func updateQuestion(){
        generateNums()
    }
    
    
    //Score handling
    @State private var showingScore = false
    @State private var showingEndScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionCounter = 0
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text("Question: \(questionCounter)")
                    .font(.largeTitle)
            }
            Spacer()
            Text("What is \(randomNum) * \(randomNumTwo) ?")
            VStack(spacing: 0){ //button monstrosity holder
                ForEach(0..<tableSet){ number in
                    VStack{
                        HStack(spacing: 0){
                            ForEach(0..<tableSet){ yNumber in
                                let displayNum = xNums[number] * xNums[yNumber]
                    
                            Button("\(displayNum)"){
                                //goodluck bc wtf
                                numberTapped(displayNum)
                                
                            }.frame(width: 31.5, height: 31.5)
                                    .background(colors.randomElement())
                                    .foregroundColor(.white)
                                    .border(.black, width: 1.2)
                                    .font(.body.weight(.semibold))
                            }//end of 2nd foreach
                        }
                    }
                }//end of 1st foreach
            }//end of button monstrosity
            Spacer()
            Text("Score: \(userScore)")
                .font(.largeTitle)
        }
        .onAppear(perform: updateQuestion)
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue"){
                updateQuestion()
            }
        } message: {
            if scoreTitle == "Wrong"{
                Text("The correct answer is \(solution)")
            }
            else{
                Text("Your score is \(userScore)")
            }
        }
        .alert("Game Fin!", isPresented: $showingEndScore){
            Button("Reset game"){
                questionCounter = 0
                userScore = 0
                updateQuestion()
            }
        } message: {
            Text("You scored: \(userScore)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
