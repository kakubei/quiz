//
//  ScoreViewController.swift
//  Quiz
//
//  Created by Alex Dearden on 15/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!
    var score: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Create nice circular score like Flock of
        self.scoreLabel.text = self.score
    }
    
}
