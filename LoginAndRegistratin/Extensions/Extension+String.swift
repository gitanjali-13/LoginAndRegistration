//
//  Extension+String.swift
//  LoginAndRegistration
//
//  Created by Admin on 05/01/23.
//

import Foundation
import UIKit

extension String {
    func validateEmailId() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegex)
    }
    
    func validatePassword(min: Int = 8, max: Int = 8) -> Bool {
        var passRegex = ""
        if min >= max{
            var passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(min),}$"
        } else
        {
            var passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(min),\(max)}$"
        }
        
        return applyPredicateOnRegex(regexStr: passRegex)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherSring = NSPredicate(format: "self matches %@", regexStr)
        let isValidateotherString = validateOtherSring.evaluate(with: trimmedString)
        return isValidateotherString
    }
}
