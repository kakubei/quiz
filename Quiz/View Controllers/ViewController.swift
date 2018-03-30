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
    
    var questionsModel = QuestionsModel()
    var currentQuestion: BoolQuestion! {
        didSet {
            questionLabel.text = currentQuestion.question
        }
    }
    
    let scoreSegue = "ShowScoreSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configureUI()
    }
    
    // TODO: Move this to a model
    private func configureUI() {
        currentQuestion = questionsModel.boolQuestions.first
        
        view.addTapGestureHandler(target: self, action: #selector(dismissView))
        view.addSwipeLeftGestureHandler(target: self, action: #selector(nextQuestion))
        
        totalQuestionsLabel.text = questionsModel.currentQuestionLabel(index: 0)
    }    
    
    @objc func dismissView() {
        // TODO: Don't advance to next question unless user has answered
        guard currentQuestion.answered else {
            return
        }
        nextQuestion()
        answerView.isHidden = true
    }
    
    
    @IBAction func answerButtonTapped(_ sender: AnswerButton) {
        let answer: Bool = currentQuestion.validateAnswer(sender.boolValue)
        currentQuestion.answered = true
        questionsModel.updateScore(withAnswer: answer)
        
        showAnswer(answer)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == scoreSegue {
            guard let destinationVC = segue.destination as? ScoreViewController else {
                return
            }
            
            destinationVC.score = questionsModel.scorePercentage
        }
    }
    
    fileprivate func showAnswer(_ answer: Bool) {
        guard let friendlyAnswer = currentQuestion?.showAnswer(for: answer) else {
            return
        }
        
        answerView.configureAnswerView(with: friendlyAnswer)
    }
    
    @objc private func nextQuestion() {
        if questionsModel.isLastQuestion(currentQuestion) {
            performSegue(withIdentifier: scoreSegue, sender: self)
            return
        }
        
        guard let index = questionsModel.boolQuestions.index(of: currentQuestion) else {
            return
        }
        
        totalQuestionsLabel.text = questionsModel.currentQuestionLabel(index: index)
        
        let nextIndex = index + 1
        showQuestionWithIndex(nextIndex)
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

