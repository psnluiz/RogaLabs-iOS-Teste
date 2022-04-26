//
//  ViewController.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 25/04/22.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    @IBOutlet weak var goToPostsButton: UIButton!
    @IBOutlet weak var appTitleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appTitleLabel.text = K.appTitle
        
        goToPostsButton.layer.masksToBounds = true
        goToPostsButton.layer.cornerRadius = 0.5 * goToPostsButton.frame.size.width
    }


    @IBAction func goToPostsButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: K.postsSegue, sender: self)
    }
}

