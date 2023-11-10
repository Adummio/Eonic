//
//  StringExstension.swift
//  Eonic
//
//  Created by Simone Punzo on 03/03/2020.
//  Copyright © 2020 Antonio Ferraioli. All rights reserved.
//

//import Foundation
//import UIKit
//
//extension String {
//
//    enum RegularExpressions: String {
//        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
//    }
//
//    func isValid(regex: RegularExpressions) -> Bool { return isValid(regex: regex.rawValue) }
//    func isValid(regex: String) -> Bool { return range(of: regex, options: .regularExpression) != nil }
//
//    func onlyDigits() -> String {
//        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
//        return String(String.UnicodeScalarView(filtredUnicodeScalars))
//    }   
//}
