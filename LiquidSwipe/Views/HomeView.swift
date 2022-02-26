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
    
    @GestureState var isDragging: Bool = false
    @State var dummyIndex: Int = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        ZStack {
            // Need indices for updating offset in real time
            ForEach(onboardingScreens.indices.reversed(), id: \.self) { index in
                // MARK: View
                OnboardingView(onboarding: onboardingScreens[index])
                    .clipShape(LiquidShape(offset: onboardingScreens[index].offset))
                    .padding(.trailing)
                    .ignoresSafeArea()
            }
        }
        // MARK: Arrow with Drag Gesture
        .overlay(
            Button(action: {
                
            }, label: {
                Image(systemName: "chevron.left")
                    .font(.largeTitle)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.red)
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .updating($isDragging, body: { value, out, _ in
                                out = true
                            })
                            .onChanged({ value in
                                // Update offset
                                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                    onboardingScreens[currentIndex].offset = value.translation
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    onboardingScreens[currentIndex].offset = .zero
                                }
                            })
                    )
            })
            .offset(y: 58)
            .opacity(isDragging ? 0 : 1)
            .animation(.linear, value: isDragging)
            , alignment: .topTrailing
        )
    }
    
    @ViewBuilder
    func OnboardingView(onboarding: OnboardingScreen) -> some View {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            onboarding.color
        )
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

struct LiquidShape: Shape {
    var offset: CGSize
    
    var animatableData: CGSize.AnimatableData {
        get { return offset.animatableData }
        set { offset.animatableData = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            
            // Rectangle shape
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // Curve shape
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            
            var to = 180 + (offset.height) + (-offset.width)
            to = to < 180 ? 180 : to
            
            let mid: CGFloat = 80 + ((to - 80) / 2)
           
            path.addCurve(to: CGPoint(x: rect.width, y: 180), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
        }
    }
}
