//
//  UIViewControllerExtensions.swift
//  MedReminder
//
//  Created by Sharad on 02/10/20.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, actionTitle: String, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.cancel, handler: { _ in
                completion?() ?? ()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
