//
//  DateHelper.swift
//  LaterGram
//
//  Created by Matthew Hill on 3/13/23.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
