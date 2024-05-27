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
                        Image(systemName: configuration.isExpanded ? "chevron.up" : "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12.0, height: 12.0)
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
