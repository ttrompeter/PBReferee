//
//  StorageManger.swift
//  PickleballReferee
//
//  Created by Tom Trompeter on 8/18/22.
//

import Foundation
import UIKit
import SwiftUI

enum StorageType {
    case userDefaults
    case fileSystem
}

func storeImage(image: UIImage, forKey key: String, withStoragetype storageType: StorageType) {
    if let pngRepresentation = image.pngData() {
        switch storageType {
        case .userDefaults:
            UserDefaults.standard.set(pngRepresentation, forKey: key)
        case .fileSystem:
            if let filePath = filePath(forKey: key) {
                do {
                    try pngRepresentation.write(to: filePath, options: .atomic)
                } catch {
                    print("Error saving image to fileSystem: \(error.localizedDescription)")
                }
            }
        }
    }
        
}

func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage? {
    switch storageType {
    case .userDefaults:
        if let imageData = UserDefaults.standard.object(forKey: key) as? Data {
            let image = UIImage(data: imageData)
            return image
        }
    case .fileSystem:
        if let filePath = filePath(forKey: key), let fileData = FileManager.default.contents(atPath: filePath.path), let image = UIImage(data: fileData) {
            return image
        }
           
    }
    
    return nil
}

private func filePath(forKey key: String) -> URL? {
    let fileManger = FileManager.default
    guard let documentURL = fileManger.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
    return documentURL.appendingPathComponent(key + ".png")
}

func getStoredImage(imageName: String) -> UIImage {
    //"scoresheet.png"
    //"sample_scoresheet.png"
    var imageToReturn = UIImage()
    let imageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
    let matchUIImage = UIImage(contentsOfFile: imageUrl.path)
    if matchUIImage == nil {
        imageToReturn = UIImage(named: "noimage")!
    } else {
        imageToReturn = matchUIImage!
    }
    return imageToReturn
}


//func getStoredImage(imageName: String, sampleImageName: String) -> UIImage {
//    //"scoresheet.png"
//    //"sample_scoresheet.png"
//    var imageToReturn = UIImage()
//    let imageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageName)
//    let matchUIImage = UIImage(contentsOfFile: imageUrl.path)
//    if matchUIImage == nil {
//        let sampleImageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(sampleImageName)
//        let sampleUIImage = UIImage(contentsOfFile: sampleImageUrl.path)
//        imageToReturn = sampleUIImage!
//    } else {
//        imageToReturn = matchUIImage!
//    }
//    return imageToReturn
//}



// Example calling save function
//if let buildingImage = UIImage(named: "building") {
//        DispatchQueue.global(qos: .background).async {
//            self.store(image: buildingImage,
//                        forKey: "buildingImage",
//                        withStorageType: .fileSystem)
//        }
//    }


// Example calling retreive function
//DispatchQueue.global(qos: .background).async {
//        if let savedImage = self.retrieveImage(forKey: "buildingImage",
//                                                inStorageType: .fileSystem) {
//            DispatchQueue.main.async {
//                self.savedImageDisplayImageView.image = savedImage
//            }
//        }
//    }

