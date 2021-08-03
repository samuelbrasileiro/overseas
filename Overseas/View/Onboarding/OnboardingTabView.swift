//
//  OnboardingTabView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 03/08/21.
//

import SwiftUI

struct OnboardingTabView: View {
    var delegate: OnboardingDelegate?
    
    var body: some View {
    
        TabView {
            OrganizingOnboardingView()
            KnowledgeOnboardingView(delegate: delegate)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
 
    }
}

struct OnboardingTabView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTabView()
    }
}
