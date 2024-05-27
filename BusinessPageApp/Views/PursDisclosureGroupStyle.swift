//
//  PursDisclosureGroup.swift
//  BusinessPageApp
//
//  Created by Ralston Goes on 5/23/24.
//

import SwiftUI

struct PursDisclosureGroupStyle: DisclosureGroupStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            Button {
                withAnimation {
                    configuration.isExpanded.toggle()
                }
            } label: {
                HStack {
                    configuration.label
                    Spacer()
                    withAnimation {
                        Image(systemName: configuration.isExpanded ? PursImage.chevronUp : PursImage.chevronRight)
                            .font(.system(size: 12.0, weight: .bold))
                            .foregroundStyle(Color.pursGrey)
                    }
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            if configuration.isExpanded {
                Divider()
                configuration.content
            }
        }
    }
}
