//
//  Helper.swift
//  filmProject
//
//  Created by Emir Kalkan on 9.06.2022.
//

import Foundation
import UIKit

struct Helper {
    
    func showAlert(controller: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}

