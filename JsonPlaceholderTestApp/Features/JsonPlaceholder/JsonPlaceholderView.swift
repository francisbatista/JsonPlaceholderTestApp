//
//  JsonPlaceholderView.swift
//  JsonPlaceholderTestApp
//
//  Created by Francis Batista on 13/4/25.
//

import SwiftUI

struct JsonPlaceholderView: View {
    @ObservedObject var viewModel = JsonPlaceholderViewModel()
    var body: some View {
        VStack {
            Text("JsonPlaceholder App")
                .font(.headline)
            HStack {
                Text("id")
                TextField("type an id", text: $viewModel.id)
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding()
                    .border(.gray)
            }
            Spacer()
            if let reponseData = viewModel.dataResponse {
                HStack {
                    Text("Title:")
                    Text(reponseData.title ?? "")
                }
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
                viewModel.fetchData()
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
