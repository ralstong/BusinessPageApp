//
//  CollapsibleTimingView.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/23/24.
//

import Foundation
import SwiftUI

struct CollapsibleTimingView: View {
    
    @ObservedObject var viewModel: BusinessInfoViewModel
    
    var body: some View {
        DisclosureGroup(isExpanded: $viewModel.detailsExpanded) {
            TimingDetailView(viewModel: viewModel)
        } label: {
            TimingSummaryView(viewModel: viewModel)
        }
        .disclosureGroupStyle(PursDisclosureGroupStyle())
        .padding(17.0)
    }
}
