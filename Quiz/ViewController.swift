//
//  ViewController.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import Cartography
import Bond
import ReactiveKit

class ViewController: UIViewController, Dismissable {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: TrueButton!
    @IBOutlet weak var falseButton: FalseButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var answerView: AnswerView!
    
    let questionsModel = QuestionsModel()
    var currentQuestion: BoolQuestion!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.configureUI()
    }
    
    // TODO: Move this to a model
    private func configureUI() {
        self.currentQuestion = self.questionsModel.boolQuestions.first
        self.questionLabel.text = currentQuestion?.question
        
        self.view.addTapGesureHandler(target: self, action: #selector(dismissView))
        
        self.view.addSwipeLeftGestureHandler(target: self, action: #selector(nextQuestion))
    }    
    
    private func dismissView() {
        self.answerView.dismissView()
    }
    
    
    @IBAction func buttonTapped(_ sender: AnswerButton) {
        let answer: Bool = currentQuestion?.correctAnswer == sender.boolValue
        self.showAnswer(answer)
    }
    
    fileprivate func showAnswer(_ answer: Bool) {
        guard let friendlyAnswer = self.currentQuestion?.showAnswer(for: answer) else {
            return
        }
        
        self.answerView.configureAnswerView(with: friendlyAnswer)
    }
    
    @objc private func nextQuestion() {
        if self.questionsModel.isLastQuestion(currentQuestion) {
            return
        }
        
        guard let index = self.questionsModel.boolQuestions.index(of: currentQuestion) else {
            return
        }
        
        let nextIndex = index + 1
        self.showQuestionWithIndex(nextIndex)
    }
    
    private func showQuestionWithIndex(_ nextIndex: Int) {
        UIView.animate(withDuration: 0.3, animations: {
            self.questionLabel.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.questionLabel.text = self.questionsModel.boolQuestions[nextIndex].question
                self.questionLabel.alpha = 1.0
            })
        })
    }
    
//    private func configureAnswerView(with answer: String) {
//        // TODO: Put all this into a model file!
//
//        let answerLabel = UILabel()
//        answerLabel.text = answer
//        answerLabel.adjustsFontSizeToFitWidth = true
//        answerLabel.textAlignment = .center
//        answerLabel.font = answerLabel.font.withSize(100)
//
//        answerView.backgroundColor = UIColor(white: 0.7, alpha: 1.0)
//
//        self.view.addSubview(answerView)
//        answerView.addSubview(answerLabel)
//
////        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
//        answerView.addGestureRecognizer(self.tap)
//
//        let preferredWidth: CGFloat = 350
//
//        constrain(self.view, answerView, answerLabel) { superview, answerView, answerLabel in
//            answerView.width == preferredWidth
//            answerView.height == preferredWidth
//            answerView.centerX == superview.centerX
//            answerView.centerY == superview.centerY
//
//            answerLabel.width == answerView.width
//            answerLabel.height == answerView.height
//            answerLabel.centerX == answerView.centerX
//            answerLabel.centerY == answerView.centerY
//        }
//
//        answerView.layer.cornerRadius = 50
//    }
    
//    @objc func dismissView() {
//        self.answerView.removeFromSuperview()
//    }
    
}

