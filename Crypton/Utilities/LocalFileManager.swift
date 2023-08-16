//
//  LocalFileManager.swift
//  Crypton
//
//  Created by MBA-0019 on 20/06/23.
//

import Foundation
import SwiftUI

class LocalFileManager
{
    static var instance = LocalFileManager()
    init() { }
    
    func getImageDownload(image : UIImage,imageName : String,folderName : String) {
        guard let data = image.pngData() else {return}
        let url = getUrlForImage(imageName: imageName, folderName: folderName)!
        do
        { try data.write(to: url)}
        catch let error
        { print("There is an error \(error)") }
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getUrlForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: url.path){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error in creating a folder : \(error)")
            }
        }
    }
    func getImage(folderName : String,imageName : String) -> UIImage?
    {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.pathExtension) else
        {
          return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func getUrlForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        return url
    }
    
    private func getUrlForImage(imageName : String, folderName : String) -> URL? {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else {return nil}
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}
