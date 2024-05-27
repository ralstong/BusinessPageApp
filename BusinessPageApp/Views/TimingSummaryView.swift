//
//  TimingSummaryView.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/27/24.
//

import Foundation
import SwiftUI

struct TimingSummaryView: View {
    
    @ObservedObject var viewModel: BusinessInfoViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.isOpenText)
                    .font(.custom(PursFont.hindSiliguriRegular, size: 18.0))
                    .foregroundStyle(Color.pursGrey)
                Image(systemName: PursImage.circleFill)
                    .resizable()
                    .foregroundStyle(
                        viewModel.isOpenNowState.color
                    )
                    .frame(width: 7.0, height: 7.0)
                Spacer()
            }
            Text(PursText.seeFullHours)
                .font(.custom(PursFont.chivoLight, size: 12.0))
                .foregroundStyle(Color.pursGrey.opacity(0.31))
        }
    }
}
