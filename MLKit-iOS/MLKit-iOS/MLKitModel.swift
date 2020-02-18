//
//  MLKitModel.swift
//  MLKit-iOS
//
//  Created by Patrick Baxter on 18/02/20.
//  Copyright © 2020 Logos Eros. All rights reserved.
//

import Foundation
import Photos
import Firebase

class MLKitModel: ObservableObject {
    @Published var images: [(image:UIImage, classifications: [String])] = []
    var imageManager: PHImageManager = PHImageManager()
    
    init() {
        self.fetchPhotos()
    }
    
    public func fetchPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        let assets = (0..<fetchResult.count).map{fetchResult.object(at: $0)}
        self.images = assets.map{(image: requestImages(asset: $0), classification: [])}
    }
    
    private func requestImages(asset: PHAsset)->UIImage {
        var tempImage: UIImage!
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = true
        self.imageManager.requestImage(for: asset,
                                       targetSize: CGSize(width: 800, height: 800),
                                       contentMode: PHImageContentMode.aspectFit,
                                       options: options
        ) {(image, _) in
            if let image = image {
                tempImage = image
            }
        }
        return tempImage
    }
    
    public func evaluate(){
        let vImages = images.map{VisionImage(image: $0.image)}
        guard vImages.count > 0 else {return}
        print("evaluating...")
        let labeler = Vision.vision().onDeviceImageLabeler()
        for (idx, img) in vImages.enumerated() {
            labeler.process(img){ labels, error in
                guard error == nil, let labels = labels else { return }
                for label in labels {
                    let labelText = label.text
                    let entityId = label.entityID
                    let confidence = label.confidence
                    self.images[idx].classifications.append("label: \(labelText) id: \(entityId!) confidence: \(confidence!)")
                }
            }
        }
    }
}
