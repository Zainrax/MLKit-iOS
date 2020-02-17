//
//  ContentView.swift
//  MLKit-iOS
//
//  Created by Patrick Baxter on 18/02/20.
//  Copyright © 2020 Logos Eros. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var images: [UIImage]
    let mlkit = MLKitModel()
    
    var imageView: some View {
        ScrollView(.vertical){
            VStack{
                ForEach(images, id: \.self){ image in
                    Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: 300, height: 300, alignment: .center)
                }
            }
        }
    }
    
    var bottomBar: some View {
        GeometryReader{ geo in
            HStack {
                Button(action: {
                    self.mlkit.images = self.images
                    self.mlkit.evaluate()
                }) {
                Text("Evaluate")
                }
            }.frame(width: geo.size.width, height: 30)
        }.frame( height: 30, alignment: .bottom)
    }
    
    var body: some View {
        VStack{
        imageView
        bottomBar
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let images = (1...10).map{UIImage(named: "IMG\($0)")}
        return ContentView(images: images as! [UIImage])
    }
}
