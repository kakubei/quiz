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
    var currentQuestion: BoolQuestion!
    let answerView = AnswerView()
    
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
        let answer: Bool = currentQuestion.correctAnswer == sender.boolValue
        self.showAnswer(answer)
    }
    
    fileprivate func showAnswer(_ answer: Bool) {
        let friendlyAnswer = self.currentQuestion.showAnswer(for: answer)
        print("answer:", friendlyAnswer)
        
        self.configureAnswerView(with: friendlyAnswer)
    }
    
    private func configureAnswerView(with answer: String) {
        
        self.answerView.answerString = answer
        self.answerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.answerView)
        
        self.answerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -60).isActive = true
        self.answerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, constant: -200).isActive = true
        self.answerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.answerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}

