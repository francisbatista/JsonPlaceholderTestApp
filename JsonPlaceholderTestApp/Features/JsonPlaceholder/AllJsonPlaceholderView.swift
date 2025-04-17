//
//  AllJsonPlaceholderView.swift
//  JsonPlaceholderTestApp
//
//  Created by Francis Batista on 13/4/25.
//

import SwiftUI

struct AllJsonPlaceholderView: View {
    @EnvironmentObject var viewModel: JsonPlaceholderViewModel
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2)
            } else if let data = viewModel.allDataResponse, !data.isEmpty, viewModel.errorMessage.isEmpty {
                Text("All Data In \(viewModel.time) Seconds")
                    .font(.headline)
                    .padding()
                ScrollView {
                    ForEach(viewModel.allDataResponse!, id: \.id) { element in
                        VStack(alignment: .leading) {
                            HStack(alignment: .firstTextBaseline, spacing: 10) {
                                Text("Id:")
                                Text("\(element.id ?? -1)")
                            }
                            HStack(alignment: .firstTextBaseline, spacing: 10) {
                                Text("Title:")
                                Text(element.title ?? "")
                                Spacer()
                            }
                            HStack(alignment: .firstTextBaseline, spacing: 10) {
                                Text("Completed:")
                                Text("\(element.completed ?? false)")
                            }
                        }
                        Divider()
                    }
                }
            } else {
                let message = viewModel.errorMessage.isEmpty ? "the list is empty" : viewModel.errorMessage
                Text(message)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding()
                    .background(viewModel.errorMessage.isEmpty ? .gray : .red)
                    .clipShape(.rect(cornerRadius: 25))
            }
        }
        .padding()
        .onAppear {
            viewModel.clearVariables()
            viewModel.fetchAll()
        }
    }
}
