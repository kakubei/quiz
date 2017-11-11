//
//  Question.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation

enum QuestionType {
    case bool, multiple
}

protocol Questionable {
    var type: QuestionType { get }
    var question: String { get }
//    var correctAnswer: Any { get }
}

protocol BoolQuestionable: Questionable {
    var correctAnswer: Bool { get }
    func validateAnswer(_ answer: Bool) -> Bool
}

protocol MultipleQuestionable {
    var correctAnswer: String { get }
    func validateAnswer(_ answer: String) -> Bool
}

struct BoolQuestion: BoolQuestionable {
    let question: String
    let type: QuestionType
    let correctAnswer: Bool
    
    func validateAnswer(_ answer: Bool) -> Bool {
        return self.correctAnswer == answer
    }
}

struct MultiQuestion: MultipleQuestionable {
    let question: String
    let type: QuestionType
    let correctAnswer: String
    
    func validateAnswer(_ answer: String) -> Bool {
        return self.correctAnswer == answer
    }
}
