//
//  OnboardingScreen.swift
//  LiquidSwipe
//
//  Created by Stanley Pan on 2022/02/26.
//

import SwiftUI

// MARK: OnboardingScreen Model and Sample Screens
struct OnboardingScreen: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var subTitle: String
    var description: String
    var pic: String
    var color: Color
    var offset: CGSize = .zero
}
