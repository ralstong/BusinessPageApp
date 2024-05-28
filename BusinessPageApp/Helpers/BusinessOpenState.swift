//
//  BusinessOpenState.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/24/24.
//

import Foundation
import SwiftUI

enum OpenIndicatorState {
    case open
    case closing
    case closed
    
    var color: Color {
        switch self {
        case .open: .statusGreen
        case .closing: .yellow
        case .closed: .red
        }
    }
}
