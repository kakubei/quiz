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

enum AnswerString: String {
    case correct
    case incorrect
    
    var friendly: String {
        return self == .correct ? "😀" : "😖"
    }
}

protocol Questionable {
    var type: QuestionType { get }
    var question: String { get }
}

protocol BoolQuestionable: Questionable {
    var correctAnswer: Bool { get }
    func validateAnswer(_ answer: Bool) -> Bool
    func showAnswer(for answer: Bool, friendly: Bool) -> String
}

struct BoolQuestion: BoolQuestionable {
    let question: String
    let type: QuestionType = .bool
    let correctAnswer: Bool
    var answered: Bool = false
    
    init(question: String, correctAnswer: Bool) {
        self.question = question
        self.correctAnswer = correctAnswer
    }
    
    func validateAnswer(_ answer: Bool) -> Bool {
        return self.correctAnswer == answer
    }
    
    // We can show friendly faces answer or just the text
    func showAnswer(for answer: Bool, friendly: Bool = true) -> String {
        let answerString: AnswerString = answer ? .correct : .incorrect
        return friendly ? answerString.friendly : answerString.rawValue
    }
}

extension BoolQuestion: Equatable { }

func ==(lhs: BoolQuestion, rhs: BoolQuestion) -> Bool {
    return lhs.question == rhs.question
}

// TODO: Use Generics for this, instead of Quiestonable item, have a generic item
//protocol MultipleQuestionable {
//    var correctAnswer: String { get }
//    func validateAnswer(_ answer: String) -> Bool
//}

//struct MultiQuestion: MultipleQuestionable {
//    let question: String
//    let type: QuestionType
//    let correctAnswer: String
//
//    func validateAnswer(_ answer: String) -> Bool {
//        return self.correctAnswer == answer
//    }
//}

