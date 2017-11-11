//
//  ViewController.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import Cartography

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: TrueButton!
    @IBOutlet weak var falseButton: FalseButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let questionsModel = QuestionsModel()
    var currentQuestion: BoolQuestion!
    // TODO: Remove this as instance variable. We justa have it so I can dismiss with tap!
    let answerView = UIView()
    
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
        
        self.configureAnswerView(with: friendlyAnswer)
    }
    
    private func configureAnswerView(with answer: String) {
        // TODO: Put all this into a model file!
        
        let answerLabel = UILabel()
        answerLabel.text = answer
        answerLabel.adjustsFontSizeToFitWidth = true
        answerLabel.textAlignment = .center
        answerLabel.font = answerLabel.font.withSize(100)
        
        answerView.backgroundColor = UIColor(white: 0.7, alpha: 0.8)
        
        self.view.addSubview(answerView)
        answerView.addSubview(answerLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        answerView.addGestureRecognizer(tapGesture)
        
        let preferredWidth: CGFloat = 350
        
        constrain(self.view, answerView, answerLabel) { superview, answerView, answerLabel in
            answerView.width == preferredWidth
            answerView.height == preferredWidth
            answerView.centerX == superview.centerX
            answerView.centerY == superview.centerY
            
            answerLabel.width == answerView.width
            answerLabel.height == answerView.height
            answerLabel.centerX == answerView.centerX
            answerLabel.centerY == answerView.centerY
        }
        
        answerView.layer.cornerRadius = 50
    }
    
    @objc func dismissView() {
        self.answerView.removeFromSuperview()
    }
    
}

