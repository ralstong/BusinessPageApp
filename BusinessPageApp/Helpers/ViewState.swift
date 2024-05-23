//
//  ViewState.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

enum ViewState<T> {
    case loading
    case error
    case data(T)
}
