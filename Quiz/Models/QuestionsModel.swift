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
    
    func isLastQuestion(_ currentQuestion: BoolQuestion) -> Bool {
        let index = self.boolQuestions.index(of: currentQuestion)
        let allQuestionsViewed = index == (self.boolQuestions.count - 1)
        return allQuestionsViewed
    }
}
