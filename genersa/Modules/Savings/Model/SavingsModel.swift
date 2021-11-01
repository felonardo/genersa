//
//  SavingsModel.swift
//  genersa
//
//  Created by Kevin Rivaldo  on 01/11/21.
//

import Foundation
import CoreData

extension Saving {
    var currentBalance: Double {
        return totalSaved - totalUsed
    }
    var needToSave: Double {
        return totalAmount - totalSaved
    }
}
