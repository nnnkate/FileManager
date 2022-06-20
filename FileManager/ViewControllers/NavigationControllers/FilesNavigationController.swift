//
//  FilesNavigationController.swift
//  FileManager
//
//  Created by Екатерина Неделько on 20.06.22.
//

import UIKit

class FilesNavigationController: UINavigationController {

    private var settingPasswordAlert: UIAlertController?

}

// MARK: AuthorizationServiceDelegate

extension FilesNavigationController: AuthorizationServiceDelegate {
    func handlePasswordIDAutorization(handler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: "Enter password",
                                                message: "To work with application, enter the application password",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default) { _ in
            guard let textFields = alertController.textFields else { return }

            if let textField = textFields.first {
                handler(textField.text)
            }
        })
        
        alertController.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
            
        }
        
        self.present(alertController, animated: true)
    }
    
    func handlePasswordSetting(handler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: "Set password",
                                                message: "To work with application, set the application password",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Save",
                                                style: .default) { _ in
            guard let textFields = alertController.textFields else { return }
            
            if let textField = textFields.first, let text = textField.text {
                handler(text)
            }
        })
        
        alertController.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.placeholder = "Password"
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
            
        }
        alertController.addTextField { textField in
            textField.isSecureTextEntry = true
            textField.placeholder = "Confirm"
            textField.addTarget(self, action: #selector(self.textChanged), for: .editingChanged)
        }
        
        alertController.actions.first?.isEnabled = false
        
        settingPasswordAlert = alertController
        
        self.present(alertController, animated: true)
        
    }
    
    @objc func textChanged(_ sender: Any) {
        if let textFields = settingPasswordAlert?.textFields, textFields.count > 1  {
            settingPasswordAlert?.actions.first?.isEnabled = textFields[0].text == textFields[1].text
        }
    }
}

