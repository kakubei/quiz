//
//  ViewController.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import SwiftyAttributes

class ViewController: UIViewController, Dismissable {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    
    @IBOutlet weak var answerView: AnswerView!
    
    var questionsModel = QuestionsModel()
    var currentQuestion: BoolQuestion! {
        didSet {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 0.5
            let attributedText = currentQuestion.question.withAttributes([.paragraphStyle(style)])
            questionLabel.attributedText = attributedText
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
        view.addSwipeUpGestureHandler(target: self, action: #selector(answerSwiped(_:)))
        view.addSwipeDownGestureHandler(target: self, action: #selector(answerSwiped(_:)))
        
        totalQuestionsLabel.text = questionsModel.setTotalQuestionsLabel(index: 0)
    }    
    
    @objc func dismissView() {
        // TODO: Don't advance to next question unless user has answered
        guard currentQuestion.answered else {
            return
        }
        nextQuestion()
        answerView.isHidden = true
    }
    
    private func processAnswer(_ answer: Bool) {
        let validatedAnswer: Bool = currentQuestion.validateAnswer(answer)
        currentQuestion.answered = true
        questionsModel.updateScore(withAnswer: validatedAnswer)
        
        showAnswer(validatedAnswer)
    }
    
    @objc func answerSwiped(_ gesture: UISwipeGestureRecognizer) {
        let answer: Bool = gesture.direction == .up ? true : false
        
        animateSwipedView(gesture.direction) {
            self.processAnswer(answer)
        }
    }
    
    /**
     Slightly moves whole view in the direction of the swipe and back
     Shoud be an extension of a view conforming to a protocol
     */
    private func animateSwipedView(_ direction: UISwipeGestureRecognizerDirection, completion: @escaping EmptyCompletion) {
        let amount: CGFloat = 30
        let duration: Double = 0.3
        
        let swipeAmount: CGFloat = direction == .up ? -amount : amount
        let start = CGAffineTransform(translationX: 0, y: swipeAmount)
        let end = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: duration, animations: {
            self.view.transform = start
        }, completion: { _ in
            UIView.animate(withDuration: duration, animations: {
                self.view.transform = end
                completion()
            })
        })
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
        
        totalQuestionsLabel.text = questionsModel.setTotalQuestionsLabel(index: index)
        
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
                self.totalQuestionsLabel.text = self.questionsModel.setTotalQuestionsLabel(index: nextIndex)
                self.questionLabel.alpha = 1.0
                self.totalQuestionsLabel.alpha = 1.0
            })
        })
    }    
    
}

