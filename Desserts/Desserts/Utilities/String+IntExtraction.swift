//
//  String+IntExtraction.swift
//  Desserts
//
//  Created by Logan Parmeter on 6/21/24.
//

import Foundation

extension String {
    /// Extracts all Decimal Numbers from a given String and returns them as a combined Int.
    /// - Returns: All Decimal Numbers present in a String, combined together as an Int. If the String
    /// is empty, or there are no numbers present, this function will return `nil`. E.g. "strIngredient12" will return 12.
    func extractInt() -> Int? {
        guard !self.isEmpty else {
            return nil
        }
        
        return Int(self.components(separatedBy: .decimalDigits.inverted).joined())
    }
}
