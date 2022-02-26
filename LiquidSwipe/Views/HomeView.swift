//
//  HomeView.swift
//  LiquidSwipe
//
//  Created by Stanley Pan on 2022/02/26.
//

import SwiftUI

struct HomeView: View {
    @State var onboardingScreens: [OnboardingScreen] = [
        OnboardingScreen(title: "Store", subTitle: "your data", description: "Access your collection of media, anytime, anywhere across all devices!", pic: "onboarding01", color: Color("customBlue")),
        OnboardingScreen(title: "Distribute", subTitle: "to everyone", description: "Easily select and share your content with a push of a button!", pic: "onboarding02", color: Color("customGrey")),
        OnboardingScreen(title: "Protect", subTitle: "with built-in privacy", description: "All content is encrypted through our rigorous algorithms!", pic: "onboard03", color: Color("customOrange"))
    ]
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
