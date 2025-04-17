//
//  JsonPlaceholderView.swift
//  JsonPlaceholderTestApp
//
//  Created by Francis Batista on 13/4/25.
//

import SwiftUI

struct JsonPlaceholderView: View {
    @ObservedObject var viewModel = JsonPlaceholderViewModel()
    var appTitle: String = "JsonPlaceholder App"
    var body: some View {
        VStack {
            Text(viewModel.withCompletion ? "\(appTitle) WithCompletion" : appTitle)
                .font(.headline)
            HStack {
                Text("id")
                TextField("type an id", text: $viewModel.id)
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding()
                    .border(.gray)
            }
            Toggle("WithCompletion", isOn: $viewModel.withCompletion)
                .padding()
            Spacer()
            if let reponseData = viewModel.dataResponse {
                HStack {
                    Text("Title:")
                    Text(reponseData.title ?? "")
                }
                Text("Time: \(viewModel.time)")
                    .padding()
            }
            Spacer()
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding()
                    .background(.red)
                    .clipShape(.rect(cornerRadius: 25))
                    
            }
            Button {
                viewModel.fetch()
            } label: {
                Text("Fetch Data")
            }
            .padding()
            
            NavigationLink {
                AllJsonPlaceholderView()
                    .environmentObject(viewModel)
            } label: {
                Text("View All Data")
            }
        }
        .padding()
    }
}
