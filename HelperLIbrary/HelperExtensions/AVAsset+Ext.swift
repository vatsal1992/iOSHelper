//
//  AVAsset+Ext.swift
//  HelperLIbrary
//
//  Created by Vatsal Shukla on 10/07/22.
//

import AVKit
import UIKit

extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 5)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
    
    func assetByTrimming(startTime: CMTime, endTime: CMTime) throws -> AVAsset {
           let duration = CMTimeSubtract(endTime, startTime)
           let timeRange = CMTimeRange(start: startTime, duration: duration)

           let composition = AVMutableComposition()

           do {
               for track in tracks {
                   let compositionTrack = composition.addMutableTrack(withMediaType: track.mediaType, preferredTrackID: track.trackID)
                   compositionTrack?.preferredTransform = track.preferredTransform
                   try compositionTrack?.insertTimeRange(timeRange, of: track, at: CMTime.zero)
               }
           } catch let error {
               throw TrimError("error during composition", underlyingError: error)
           }

           return composition
    }
    
    
    func getDuration() -> Double {
        let duration = self.duration
        let seconds = CMTimeGetSeconds(duration)
        
        return seconds
    }

  
}

struct TrimError: Error {
    let description: String
    let underlyingError: Error?

    init(_ description: String, underlyingError: Error? = nil) {
        self.description = "TrimVideo: " + description
        self.underlyingError = underlyingError
    }
}
