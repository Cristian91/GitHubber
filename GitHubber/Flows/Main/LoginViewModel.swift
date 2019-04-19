//
//  LoginPresenter.swift
//  GitHubber
//
//  Created by Cristi on 15/04/2019.
//  Copyright © 2019 Cristi. All rights reserved.
//

import UIKit

struct LoginPresenter {
    func validateLogin(userEmail email: String?, userPassword password: String?) -> Bool {
        guard let email = email, let password = password else {
            return false
        }
        
        let response = Validation.shared.validate(values: (ValidationType.email, email), (ValidationType.password, password))
        switch response {
        case .success:
            return true
        case .failure(_, let message):
            presentAlertErrorWithMessage(message.rawValue)
            return false
        }
    }
    
    func presentAlertErrorWithMessage(_ message: String) {
        let alertController = UIAlertController()
        alertController.message = message
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }

}
