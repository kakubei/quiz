//
//  ViewController.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: TrueButton!
    @IBOutlet weak var falseButton: FalseButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let questionsModel = QuestionsModel()
    var currentQuestion: Questionable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.configureUI()
    }
    
    // TODO: Move this to a model
    private func configureUI() {
        self.currentQuestion = self.questionsModel.boolQuestions.first
        self.questionLabel.text = currentQuestion?.question
    }
    
    
    @IBAction func buttonTapped(_ sender: AnswerButton) {
        let answer: Bool = (currentQuestion as! BoolQuestion).correctAnswer == sender.boolValue
        self.showAnswer(answer)
    }
    
    fileprivate func showAnswer(_ answer: Bool) {
        let friendlyAnswer: String = answer ? "Correct 😀" : "Incorrect 😖"
        print("answer:", friendlyAnswer)
    }
    
}

