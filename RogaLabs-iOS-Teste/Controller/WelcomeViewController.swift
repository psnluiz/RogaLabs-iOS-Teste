//
//  ViewController.swift
//  RogaLabs-iOS-Teste
//
//  Created by Luiz Fernando Andrade on 25/04/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var appTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appTitleLabel.text = K.appTitle
    }


    @IBAction func goToPostsButtonPressed(_ sender: Any) {
    }
}

