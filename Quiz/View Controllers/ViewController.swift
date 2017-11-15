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
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    
    @IBOutlet weak var answerView: AnswerView!
    
    let questionsModel = QuestionsModel()
    var currentQuestion: BoolQuestion! {
        didSet {
            self.questionLabel.text = currentQuestion.question
        }
    }
    
    let scoreSegue = "ShowScoreSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.configureUI()
    }
    
    // TODO: Move this to a model
    private func configureUI() {
        self.currentQuestion = self.questionsModel.boolQuestions.first
        
        self.view.addTapGestureHandler(target: self, action: #selector(dismissView))
        self.view.addSwipeLeftGestureHandler(target: self, action: #selector(nextQuestion))
        
        self.totalQuestionsLabel.text = self.questionsModel.currentQuestionLabel(index: 0)
    }    
    
    @objc func dismissView() {
        // TODO: Don't advance to next question unless user has answered
        guard self.currentQuestion.answered else {
            return
        }
        self.nextQuestion()
        self.answerView.isHidden = true
    }
    
    
    @IBAction func buttonTapped(_ sender: AnswerButton) {
        let answer: Bool = currentQuestion?.correctAnswer == sender.boolValue
        self.currentQuestion.answered = true
        self.questionsModel.updateScore(withAnswer: answer)
        
        self.showAnswer(answer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == scoreSegue {
            guard let destinationVC = segue.destination as? ScoreViewController else {
                return
            }
            
            destinationVC.score = self.questionsModel.scorePercentage
        }
    }
    
    fileprivate func showAnswer(_ answer: Bool) {
        guard let friendlyAnswer = self.currentQuestion?.showAnswer(for: answer) else {
            return
        }
        
        self.answerView.configureAnswerView(with: friendlyAnswer)
    }
    
    @objc private func nextQuestion() {
        if self.questionsModel.isLastQuestion(currentQuestion) {
            performSegue(withIdentifier: scoreSegue, sender: self)
            return
        }
        
        guard let index = self.questionsModel.boolQuestions.index(of: currentQuestion) else {
            return
        }
        
        self.totalQuestionsLabel.text = self.questionsModel.currentQuestionLabel(index: index)
        
        let nextIndex = index + 1
        self.showQuestionWithIndex(nextIndex)
    }
    
    private func showQuestionWithIndex(_ nextIndex: Int) {
        UIView.animate(withDuration: 0.3, animations: {
            self.questionLabel.alpha = 0
            self.totalQuestionsLabel.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.currentQuestion = self.questionsModel.boolQuestions[nextIndex]
                self.totalQuestionsLabel.text = self.questionsModel.currentQuestionLabel(index: nextIndex)
                self.questionLabel.alpha = 1.0
                self.totalQuestionsLabel.alpha = 1.0
            })
        })
    }    
    
}

