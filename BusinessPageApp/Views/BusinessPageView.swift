//
//  BusinessPageView.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/20/24.
//

import SwiftUI

struct BusinessPageView: View {
    
    @StateObject var viewModel = BusinessInfoViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .error:
                Color.red
            case .data(let info):
                    VStack {
                        Text(info.locationName)
                            .font(.custom("Fira Sans", size: 54.0))
                            .bold()
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(23.0)
                    .background {
                        Image("purs_img", bundle: nil)
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea(edges: .vertical)
                    }
            }
        }
        .task {
            await viewModel.loadInfo()
        }
    }
}
