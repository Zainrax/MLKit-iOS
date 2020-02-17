//
//  MLKitModel.swift
//  MLKit-iOS
//
//  Created by Patrick Baxter on 18/02/20.
//  Copyright © 2020 Logos Eros. All rights reserved.
//

import Foundation
import Firebase

class MLKitModel: ObservableObject {
    var images: [UIImage] = []
    
    public func evaluate(){
        print(images)
    }
}
