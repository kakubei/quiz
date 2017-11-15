//
//  AnswerView.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import Cartography

class AnswerView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureUI()
    }
    
    private func configureUI() {
        self.layer.cornerRadius = 50
    }
    
     func configureAnswerView(with answer: String) {
        self.isHidden = false
        
        let answerLabel = UILabel()
        
        answerLabel.text = answer
        answerLabel.font = answerLabel.font.withSize(100)
        answerLabel.textAlignment = .center
       
        // TODO: Change background colour depending on right or wrong answer. Use the Enum for this.
        self.backgroundColor = UIColor(white: 0.7, alpha: 1.0)
        
        self.addSubview(answerLabel)
        
        let preferredWidth: CGFloat = 350
        
        constrain(self.superview!, self, answerLabel) { superview, answerView, answerLabel in
            answerView.width == preferredWidth
            answerView.height == preferredWidth
            answerView.centerX == superview.centerX
            answerView.centerY == superview.centerY

            answerLabel.width == answerView.width
            answerLabel.height == answerView.height
            answerLabel.centerX == answerView.centerX
            answerLabel.centerY == answerView.centerY
        }
    }
}
