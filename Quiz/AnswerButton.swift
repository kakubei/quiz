//
//  AnswerButton.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    var mark: String = "✓"
    
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
        self.specificInit()
    }
    
    convenience init?(mark: String) {
        self.init(coder: NSCoder())
        self.commonInit()
    }
    
    func specificInit() {
        self.backgroundColor = .green
        self.setTitle(self.mark, for: .normal)
    }
}


class FalseButton: AnswerButton {
    
    override func specificInit() {            
        self.backgroundColor = .red
        self.setTitle("X", for: .normal)
    }
}
