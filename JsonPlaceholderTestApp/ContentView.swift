//
//  ContentView.swift
//  JsonPlaceholderTestApp
//
//  Created by Francis Batista on 13/4/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                JsonPlaceholderView()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
