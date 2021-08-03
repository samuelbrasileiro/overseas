//
//  OnboardingTabView.swift
//  Overseas
//
//  Created by Elaine  Cruz on 03/08/21.
//

import SwiftUI

struct OnboardingTabView: View {
    var body: some View {
        
        TabView {
            OrganizingOnboardingView()
            KnowledgeOnboardingView()
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
