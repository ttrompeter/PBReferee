//
//  ExtensionUIImage.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/8/22.
//

import UIKit

extension UIImage {
    
    func saveToFile(atURL url: URL) {
        guard let data = self.pngData() else { return }
        do {
            try data.write(to: url)
            print("Screenshot saved at path \(url.absoluteString)")
        }
        catch (let error) {
            print("Error \(error.localizedDescription)")
        }
    }
    
    func saveScoresheetToDocuments() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //let name = "match-\(Date.now.timeIntervalSince1970).png"
        let fileURL = paths[0].appendingPathComponent("scoresheet.png")
        saveToFile(atURL: fileURL)
    }
    
    func saveStatisticsToDocuments() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //let name = "match-\(Date.now.timeIntervalSince1970).png"
        let fileURL = paths[0].appendingPathComponent("statistics.png")
        saveToFile(atURL: fileURL)
    }
    
    // TODO: - Temporary test for development - delete in production
    func saveFunctionalityButtonsToDocuments() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //let name = "match-\(Date.now.timeIntervalSince1970).png"
        let fileURL = paths[0].appendingPathComponent("functionality.png")
        saveToFile(atURL: fileURL)
    }
    
}

// Remove item using FileManger
//try fileManager.removeItem(atPath: filePath)

