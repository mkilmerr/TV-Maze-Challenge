//
//  BiometricAuthenticationView.swift
//  TVMaze
//
//  Created by longarinas on 10/01/25.
//

import SwiftUI

struct BiometricAuthenticationView: View {
    @StateObject private var viewModel: BiometricAuthenticationViewModel
    
    init(viewModel: BiometricAuthenticationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "faceid")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("Authentication Required")
                . bold()
                .font(.title)
            
            if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            }
            
            Button("Authenticate with Biometrics") {
                Task {
                    await viewModel.authenticate()
                }
            }
            .disabled(!viewModel.isBiometricAvailable)
        }
        .padding()
        .onAppear {
            if viewModel.isBiometricAvailable {
                Task {
                    await viewModel.authenticate()
                }
            }
        }
    }
}

#Preview {
    BiometricAuthenticationView(
        viewModel: BiometricAuthenticationViewModel(
            authenticationUseCase: BiometricAuthenticationUseCaseMock()
        )
    )
}
