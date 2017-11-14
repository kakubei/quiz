//
//  ViewController.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import Cartography

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
        
        self.view.addTapGestureHandler(target: self, action: #selector(dismissView))
        
        self.view.addSwipeLeftGestureHandler(target: self, action: #selector(nextQuestion))
    }    
    
    @objc func dismissView() {
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
    
}

