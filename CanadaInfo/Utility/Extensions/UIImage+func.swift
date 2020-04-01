//
//  UIImage+func.swift
//  CanadaInfo
//
//  Created by Dinny Anand on 01/04/2020.
//  Copyright © 2020 Dinny Anand. All rights reserved.
//
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    //image is cached once downloaded and saved with url as the key.
    func imageFromUrl(_ urlString: String) {
        image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            //the image is downloaded using URLSession from the url
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, _, _) in
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    })
                }else{
                    DispatchQueue.main.async {
                         self.image = UIImage(systemName: "exclamationmark")
                    }
                }
            }
            dataTask.resume()
        }
    }
    func makeRoundCorners(byRadius rad: CGFloat) {
       self.layer.cornerRadius = rad
       self.clipsToBounds = true
    }
}
