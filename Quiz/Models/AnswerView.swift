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
    
    @IBOutlet weak var answerLabel: UILabel!    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
//    var answerString: String? {
//        didSet {
//            guard let answerLabel = self.answerLabel else {
//                return
//            }
//            answerLabel.text = answerString
//        }
//    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    private func configureUI() {
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        answerLabel.font = answerLabel.font.withSize(100)
        self.answerLabel.adjustsFontSizeToFitWidth = true
        self.layer.cornerRadius = 50
    }
    
     func configureAnswerView(with answer: String) {
        self.isHidden = false
        
        answerLabel.text = answer
//        answerLabel.adjustsFontSizeToFitWidth = true
//        answerLabel.textAlignment = .center
       
        
//        self.backgroundColor = UIColor(white: 0.7, alpha: 1.0)
        
//        self.addSubview(answerLabel)
        
        
//        self.addGestureRecognizer(tapGesture)
        
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
    
    @objc func dismissView() {
        self.removeFromSuperview()
    }
}
