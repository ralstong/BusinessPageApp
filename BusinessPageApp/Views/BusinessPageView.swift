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
                ZStack {
                    Color.black
                    Text(PursText.errorText)
                        .foregroundStyle(.white)
                }
                .ignoresSafeArea(.all)
            case .loaded:
                VStack(alignment: .leading) {
                    Text(viewModel.locationText)
                        .font(.custom(PursFont.firaSansBlack, size: 54.0))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 23.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.linearGradient(colors: [.black, .black.opacity(0.0)],
                                                        startPoint: .top,
                                                        endPoint: .bottom))
                    
                    CollapsibleTimingView(viewModel: viewModel)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
                        .shadow(color: .black.opacity(0.25), radius: 10.2, x: 0, y: 4.0)
                        .padding(.horizontal, 23.0)
                    
                    Spacer()
                    
                    if (!viewModel.detailsExpanded) {
                        Button(action: {}, label: {
                            VStack(alignment: .center) {
                                Image(systemName: PursImage.chevronUp)
                                    .font(.system(size: 12.0, weight: .bold))
                                    .foregroundStyle(.white.opacity(0.5))
                                    .padding(6.0)
                                Image(systemName: PursImage.chevronUp)
                                    .font(.system(size: 12.0, weight: .bold))
                                    .foregroundStyle(.white)
                                Text(PursText.viewMenu)
                                    .font(.custom(PursFont.hindSiliguriRegular, size: 24.0))
                                    .foregroundStyle(.white)
                                    .padding(6.0)
                            }
                        })
                        .frame(maxWidth: .infinity)
                        .background(.linearGradient(colors: [.black.opacity(0.0), .black],
                                                    startPoint: .top,
                                                    endPoint: .bottom))
                    }
                }
                .background {
                    Image(PursImage.background, bundle: nil)
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
