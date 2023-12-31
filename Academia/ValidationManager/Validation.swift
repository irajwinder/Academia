//
//  Validation.swift
//  Academia
//
//  Created by Rajwinder Singh on 10/23/23.
//

import Foundation
import UIKit

struct Validation {
    static func isValidName(_ name: String?) -> Bool {
        guard let name = name, !name.isEmpty else {
            return false
        }
        return true
    }
    
    static func isValidNumber(_ number: Int?) -> Bool {
        guard let number = number, number > 0 else {
            return false
        }
        return true
    }
    
    static func isValidGPA(_ number: Double?) -> Bool {
        guard let number = number, number > 0.0 else {
            return false
        }
        return true
    }
    
    static func isValidPhoneNumber(_ phoneNumber: String?) -> Bool {
        guard let phoneNumber = phoneNumber, !phoneNumber.isEmpty else {
            return false
        }
        let phoneRegex = "^\\d{10}$" // Validates 10-digit phone numbers
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }

    
    static func showAlert(on viewController: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        viewController.present(alert, animated: true, completion: nil)
    }

}
