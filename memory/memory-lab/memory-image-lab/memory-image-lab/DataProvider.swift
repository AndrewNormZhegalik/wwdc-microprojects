//
//  Untitled.swift
//  memory-image-lab
//
//  Created by Andrey on 18.07.2026.
//

final class DataProvider {
    var callback: (() -> Void)?
    weak var delegate: LeakyDelegate?
    
    deinit {
        print("Provider deinited")
    }
}
