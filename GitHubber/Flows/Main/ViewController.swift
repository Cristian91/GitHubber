//
//  ViewController.swift
//  GitHubber
//
//  Created by Cristi on 15/04/2019.
//  Copyright © 2019 Cristi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let presenter: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // So from the requirements, I assumed that there is no need to authenticate to Github, as the api doesn't require you to be authenticated in order to perform requests. So I've just done a check on the email and password. If it were to authenticate to Github, this approach wouldn't work and the proper approach would have been, I think, to use the IBAction of the login button and use a closure to perform the segue on a valid login
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return presenter.validateLogin(userEmail: emailTextField.text, userPassword: passwordTextField.text)
    }
}

