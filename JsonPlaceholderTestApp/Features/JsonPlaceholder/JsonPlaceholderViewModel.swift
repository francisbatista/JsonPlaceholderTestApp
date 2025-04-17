//
//  JsonPlaceholderViewModel.swift
//  JsonPlaceholderTestApp
//
//  Created by Francis Batista on 13/4/25.
//
import SwiftUI
import MySwiftFramework

class JsonPlaceholderViewModel: ObservableObject {
    let useCase = JsonPlaceholderUsecase()
    @Published var id: String = ""
    @Published var dataResponse: JsonPlaceholderResponse?
    @Published var errorMessage: String = ""
    @Published var allDataResponse: [JsonPlaceholderResponse]?
    @Published var isLoading: Bool = false
    @Published var time: Double = 0.0
    @Published var withCompletion: Bool = false
    
    func clearVariables() {
        id = ""
        dataResponse = nil
        allDataResponse = nil
        errorMessage = ""
        isLoading = false
    }
    
    @MainActor
    func fetch() {
        if withCompletion {
            print("WITH COMPLETION HANDLER FLOW")
            fetchDataWithCompletionHandler()
        } else {
            print("ASYNC AWAIT FLOW")
            fetchData()
        }
    }
    
    @MainActor
    func fetchData() {
        Task {
            let startDate = Date()
            let response = await useCase.getJsonPlaceholderData(id: Int(id) ?? 1)
            switch response {
            case .success(let data):
                dataResponse = data
            case .failure(let error):
                dataResponse = nil
                errorMessage = error.errorDescription ?? ""
            }
            let endDate = Date()
            time = endDate.timeIntervalSince(startDate)
        }
    }
    

    func fetchDataWithCompletionHandler() {
        let startDate = Date()
        useCase.getJsonPlaceholderData(id: Int(id) ?? 1) { [self] result in
            switch result {
            case .success(let response):
                dataResponse = response
            case .failure(let error):
                dataResponse = nil
                errorMessage = error.errorDescription ?? ""
            }
            let endDate = Date()
            time = endDate.timeIntervalSince(startDate)
        }
    }
    
    
    
    @MainActor func fetchAll() {
        if withCompletion {
            print("WITH COMPLETION HANDLER FLOW")
            fetchAllDataWithCompletionHandler()
        } else {
            print("ASYNC AWAIT FLOW")
            fetchAllData()
        }
    }
    
    @MainActor
    func fetchAllData() {
        Task {
            isLoading = true
            let startDate = Date()
            let response = await useCase.getAllJsonPlaceholderData()
            isLoading = false
            switch response {
            case .success(let data):
                allDataResponse = data
            case .failure(let error):
                allDataResponse = nil
                errorMessage = error.errorDescription ?? ""
            }
            let endDate = Date()
            time = endDate.timeIntervalSince(startDate)
        }
    }
    
    func fetchAllDataWithCompletionHandler() {
        isLoading = true
        let startDate = Date()
        useCase.getAllJsonPlaceholderData { [self] result in
            switch result {
            case .success(let data):
                allDataResponse = data
            case .failure(let error):
                allDataResponse = nil
                errorMessage = error.errorDescription ?? ""
            }
            isLoading = false
            let endDate = Date()
            time = endDate.timeIntervalSince(startDate)
        }
    }
}
