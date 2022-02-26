//
//  HomeView.swift
//  LiquidSwipe
//
//  Created by Stanley Pan on 2022/02/26.
//

import SwiftUI

struct HomeView: View {
    @State var onboardingScreens: [OnboardingScreen] = [
        OnboardingScreen(title: "Store", subTitle: "your data", description: "Access your collection of media, anytime, anywhere across all devices!", pic: "onboard01", color: Color("customBlue")),
        OnboardingScreen(title: "Distribute", subTitle: "to everyone", description: "Easily select and share your content with a push of a button!", pic: "onboard02", color: Color("customGrey")),
        OnboardingScreen(title: "Protect", subTitle: "with built-in privacy", description: "All content is encrypted through our rigorous algorithms!", pic: "onboard03", color: Color("customOrange"))
    ]
    
    var body: some View {
        ZStack {
            // Need indices for updating offset in real time
            ForEach(onboardingScreens.indices.reversed(), id: \.self) { index in
                // MARK: View
                OnboardingView(onboarding: onboardingScreens[index])
            }
        }
    }
    
    @ViewBuilder
    func OnboardingView(onboarding: OnboardingScreen) -> some View {
        ZStack {
            onboarding.color
            
            VStack {
                Image(onboarding.pic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(40)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(onboarding.title)
                        .font(.system(size: 45))
                    
                    Text(onboarding.subTitle)
                        .font(.system(size: 50, weight: .bold))
                    
                    Text(onboarding.description)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding(.top)
                        .frame(width: getScreenSize().width - 100)
                        .lineSpacing(8)
                }
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding([.trailing, .top])
            }
        }
        .ignoresSafeArea()
    }
}

extension View {
    func getScreenSize() -> CGRect {
        return UIScreen.main.bounds
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
