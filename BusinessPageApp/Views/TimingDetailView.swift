//
//  TimingDetailView.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/27/24.
//

import Foundation
import SwiftUI

struct TimingDetailView: View {
    
    @ObservedObject var viewModel: BusinessInfoViewModel

    var body: some View {
        ForEach(viewModel.daysOfTheWeek, id: \.self) { key in
            if let times = viewModel.weeklyTimes[key] {
                HStack(alignment: .top) {
                    Text(key)
                        .font(viewModel.isOpenNowState != .closed && Date().weekday() == key ?
                            .custom(PursFont.hindSiliguriBold, size: 18.0) :
                            .custom(PursFont.hindSiliguriRegular, size: 18.0)
                        )
                        .foregroundStyle(Color.pursGrey)
                    Spacer()
                    VStack(alignment: .trailing) {
                        ForEach(0..<times.count, id: \.self) { i in
                            let t = times[i]
                            Text(viewModel.setTimeRangeText(from: t.startTime, to: t.endTime)
                                 + (times.count > 1 && i != times.count - 1 ? "," : "")
                            )
                            .font(viewModel.isOpenNowState != .closed && Date().weekday() == key ?
                                .custom(PursFont.hindSiliguriBold, size: 18.0) :
                                .custom(PursFont.hindSiliguriRegular, size: 18.0)
                            )
                            .foregroundStyle(Color.pursGrey)
                        }
                    }
                }
            }
        }
    }
}
