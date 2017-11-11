//
//  ViewController.swift
//  Quiz
//
//  Created by Alex Dearden on 11/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: AnswerButton!
    @IBOutlet weak var falseButton: FalseButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.configureUI()
    }
    
    // TODO: Move this to a model
    private func configureUI() {
        
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // Use sender class (casting it) to determine right or wrong answer
    }
    
}

