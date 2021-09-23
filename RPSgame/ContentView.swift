//
//  ContentView.swift
//  RPSgame
//
//  Created by Harpuneet Singh on 2021-08-26.
//

import SwiftUI

struct ContentView: View {
    @State private var round = 0
    @State private var score = 0
//    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var correctAnswer = Bool.random()
    
    var answers = ["Rock", "Paper", "Scissors"]
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertDismissText = ""
    @State private var alertAction = {}
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 30) {
                Text("Round: \(round)/10")
                Text("Score: \(score)/10")
            }.font(.title3)
            ForEach(0..<answers.count) { number in
                Button(action: {
                    self.clickButton((number != 0))
                }) {
                    Text(self.answers[number])
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(alertDismissText)) {
                self.alertAction()
            })
        }
    }
    
    func resetGame() {
        self.round = 0
        self.score = 0
        self.resetRound()
    }
    
    func resetRound() {
        round += 1
        correctAnswer = Bool.random()
    }
    
    func clickButton(_ button: Bool) {
        switch round {
        case 0..<10:
            if button == correctAnswer {
                score += 1
                alertTitle = "You win!"
                if score == 1 {
                    alertMessage = "You've won \(score) round."
                } else {
                    alertMessage = "You've won \(score) rounds."
                }
            } else {
                alertTitle = "You lose!"
                if score == 1 {
                    alertMessage = "You've won \(score) round."
                } else {
                    alertMessage = "You've won \(score) rounds."
                }
            }
            alertDismissText = "Play Again"
            alertAction = resetRound
            showAlert = true
        case 10:
            alertTitle = "Game over!"
            if score == 1 {
                alertMessage = "You won \(score) round out of 10. Would you like to play again?"
            } else {
                alertMessage = "You won \(score) rounds out of 10. Would you like to play again?"
            }
            alertDismissText = "Reset game"
            showAlert = true
            alertAction = resetGame
        default:
            return
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
