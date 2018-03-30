//
//  QuestionsModel.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation

struct QuestionsModel {
    var boolQuestions: [BoolQuestion] = []
    var score: Double = 0 {
        didSet {
            let totalQuestions = Double(self.boolQuestions.count)
            let percentage: Double = (self.score / totalQuestions) * 100
            self.scorePercentage = String(percentage)
        }
    }
    var scorePercentage: String = "0"
    
    init() {
        self.createQuestions()
    }
    
    fileprivate mutating func createQuestions() {
        let firstQuestion = BoolQuestion(question: "Sasha is cute", correctAnswer: true)
        let secondQuestion = BoolQuestion(question: "Mosquitoes have teeth", correctAnswer: true)
        let thirdQuestion = BoolQuestion(question: "WWII began in 1938", correctAnswer: false)
        let fourthQuestion = BoolQuestion(question: "Strawberries are the only fruit with the seeds on the outside", correctAnswer: true)
        
        // TODO: Map?
        [firstQuestion, secondQuestion, thirdQuestion, fourthQuestion].forEach { question in
            self.boolQuestions.append(question)
        }        
    }
    
    func currentQuestionLabel(index: Int) -> String {
        let totalQuestions = self.boolQuestions.count
        // NOTE: Don't change this to send nextIndex because it won't work for the first question
        let indexToDisplay = index + 1
        return "\(indexToDisplay) - \(totalQuestions)"
    }
    
    func isLastQuestion(_ currentQuestion: BoolQuestion) -> Bool {
        let index = self.boolQuestions.index(of: currentQuestion)
        let allQuestionsViewed = index == (self.boolQuestions.count - 1)
        return allQuestionsViewed
    }
    
    mutating func updateScore(withAnswer correctAnswer: Bool) {
        if correctAnswer {
            self.score += 1
        }
    }
}
