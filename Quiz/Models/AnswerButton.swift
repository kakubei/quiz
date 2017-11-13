//
//  AnswerButton.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    var mark: String = ""
    var boolValue: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 60)
        // circular background
        self.layer.cornerRadius = self.frame.width / 2
        
        self.backgroundColor = .black
        self.setTitle(self.mark, for: .normal)
    }

}

class TrueButton: AnswerButton {
    override func commonInit() {
        super.commonInit()
        
        self.backgroundColor = Colours.greenColour
        self.setTitle("✓", for: .normal)        
    }
}

class FalseButton: AnswerButton {
    
    override func commonInit() {
        super.commonInit()
        self.backgroundColor = Colours.redColour
        self.setTitle("X", for: .normal)
        self.boolValue = false
    }
}
