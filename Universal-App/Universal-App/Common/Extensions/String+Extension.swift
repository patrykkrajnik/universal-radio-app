//
//  String+Extension.swift
//  Universal-App
//
//  Created by Patryk Krajnik on 26/03/2022.
//

import Foundation

extension String {
    func handleIfEmpty() -> Self {
        return self.isEmpty ? " " : self
    }
}
