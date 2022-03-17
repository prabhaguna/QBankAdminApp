//
//  AdminApp.swift
//  Shared
//
//  Created by Saadhurya on 12/03/22.
//

import SwiftUI

@main
struct AdminApp: App {
    var body: some Scene {
        WindowGroup {
            ContainerView()
        }
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
