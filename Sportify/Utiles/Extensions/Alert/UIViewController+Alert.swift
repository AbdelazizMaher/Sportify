//
//  UIViewController+Alert.swift
//  Sportify
//
//  Created by Abdelaziz on 03/06/2025.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(
        title : String,
        message : String,
        preferredStyle: UIAlertController.Style = .alert,
        okTitle : String? = nil,
        cancelTitle : String? = nil,
        deleteTitle : String? = nil,
        onOk : (()->Void)? = nil,
        onCancel : (()->Void)? = nil,
        onDelete : (()->Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        if let okTitle = okTitle {
            let okAction = UIAlertAction(title: okTitle, style: .default) { _ in
                onOk?()
            }
            alert.addAction(okAction)
        }
        
        if let deleteTitle = deleteTitle {
            let deleteAction = UIAlertAction(title: deleteTitle, style: .destructive) { _ in
                onDelete?()
            }
            alert.addAction(deleteAction)
        }
        
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { _ in
                onCancel?()
            }
            alert.addAction(cancelAction)
        }
        
        present(alert, animated: true, completion: nil)
    }
}
