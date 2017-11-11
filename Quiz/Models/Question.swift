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
    func showAnswer(for answer: Bool) -> String
}

struct BoolQuestion: BoolQuestionable {
    let question: String
    let type: QuestionType = .bool
    let correctAnswer: Bool
    
    func validateAnswer(_ answer: Bool) -> Bool {
        return self.correctAnswer == answer
    }
    
    func showAnswer(for answer: Bool) -> String {
        let answerString: AnswerString = self.correctAnswer == answer ? .correct : .incorrect
        return answerString.friendly
    }
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
