//
//  AnswerView.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class AnswerView: UIView {
    
    @IBOutlet weak var answerLabel: UILabel!

    var answerString: String? {
        didSet {
            guard let answerLabel = self.answerLabel else {
                return
            }
            answerLabel.text = answerString
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.answerLabel.adjustsFontSizeToFitWidth = true
//        self.backgroundColor = .white
    }
}
