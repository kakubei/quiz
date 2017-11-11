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
    
    // TODO: Called upon init
    fileprivate mutating func createQuestions() {
        let firstQuestion = BoolQuestion(question: "Sasha is cute", correctAnswer: true)
//        let secondQuestion = MultiQuestion(question: "When did WWI start?", type: .multiple, correctAnswer: "1914")
        let thirdQuestion = BoolQuestion(question: "WWII began in 1938", correctAnswer: false)
        
        [firstQuestion, thirdQuestion].forEach { question in
            self.boolQuestions.append(question)
        }        
    }    
}
