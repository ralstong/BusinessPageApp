//
//  BusinessInfoViewModel.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import Foundation

class BusinessInfoViewModel: ObservableObject {
    
    typealias State = ViewState<BusinessInfo>
    
    @Published var state: State
    var apiService: BusinessInfoService
    
    init(state: State = .loading, apiService: BusinessInfoService = BusinessInfoAPI()) {
        self.state = state
        self.apiService = apiService
    }
    
    func loadInfo() async {
        updateState(.loading)
        do {
            let info = try await apiService.fetchLocationData()
            updateState(.data(info))
        } catch let apiError as APIError {
            print("APIError: \(apiError.localizedDescription)")
            updateState(.error)
        } catch {
            print("Error: \(error.localizedDescription)")
            updateState(.error)
        }
    }
    
    func updateState(_ vs: State) {
        Task { @MainActor in
            state = vs
        }
    }
}
