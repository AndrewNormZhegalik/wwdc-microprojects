//
//  ContentView.swift
//  memory-image-lab
//
//  Created by Andrey on 17.07.2026.
//

import SwiftUI

struct ContentView: View {
    @State var image: UIImage?
    @State var showLeaky: Bool = false
    
    var body: some View {
        VStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            }
            
            VStack {
                Button {
                    image = UIImage(contentsOfFile: Bundle.main.url(forResource: "big", withExtension: "jpg")!.path)
                } label : {
                    Text("Load full")
                        .padding(10)
                }
                .contentShape(Rectangle())
                
                Button {
                    image = downsample(name: "big", to: 1200)
                } label : {
                    Text("downsampling")
                        .padding(10)
                }
                .contentShape(Rectangle())
                
                Button {
                    showLeaky = true
                } label : {
                    Text("showLeaky screen")
                        .padding(10)
                }
                .contentShape(Rectangle())
            }
            .padding(20)
            
            Button {
                image = nil
            } label: {
                Text("RESET")
                    .padding(20)
                    .foregroundColor(.red)
            }
            
        }
        .padding()
        .sheet(isPresented: $showLeaky) {
            LeakyScreen()
        }
    }
    
    func downsample(name: String, to maxPixels: CGFloat) -> UIImage? {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let source = CGImageSourceCreateWithURL(url as CFURL, nil)
        else {
            return nil
        }
        
        let options: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixels,
            kCGImageSourceShouldCacheImmediately: true
        ]
        
        guard let cgImage = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    ContentView()
}
