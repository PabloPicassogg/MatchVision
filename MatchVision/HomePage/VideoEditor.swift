//
//  VideoEditor.swift
//  MatchVision
//
//  Created by LoneRunner on 2024/4/29.
//

import Foundation
import AVFoundation

class VideoEditor {
    func createSegmentedVideo(from url: URL) -> AVPlayerItem {
        let composition = AVMutableComposition()
        let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let compositionAudioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)

        let asset = AVURLAsset(url: url)

        //同时加载视频和音频Track
        let dispatchGroup = DispatchGroup()
        var firstVideoTrack: AVAssetTrack?
        var firstAudioTrack: AVAssetTrack?

        dispatchGroup.enter()
        asset.loadTracks(withMediaType: .video) { tracks, error in
            firstVideoTrack = tracks?.first
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        asset.loadTracks(withMediaType: .audio) { tracks, error in
            firstAudioTrack = tracks?.first
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            // 确保首先获得video和audio tracks
            guard let videoTrack = firstVideoTrack, let audioTrack = firstAudioTrack else { return }

            // 时间段0-10秒
            let firstRange = CMTimeRange(start: CMTime.zero, duration: CMTimeMakeWithSeconds(10, preferredTimescale: 1))
            try? compositionVideoTrack?.insertTimeRange(firstRange, of: videoTrack, at: .zero)
            try? compositionAudioTrack?.insertTimeRange(firstRange, of: audioTrack, at: .zero)

            // 时间段15-18秒
            let secondRange = CMTimeRange(start: CMTimeMakeWithSeconds(15, preferredTimescale: 1), duration: CMTimeMakeWithSeconds(3, preferredTimescale: 1))
            try? compositionVideoTrack?.insertTimeRange(secondRange, of: videoTrack, at: CMTimeMakeWithSeconds(10, preferredTimescale: 1))  // 续接第一段
            try? compositionAudioTrack?.insertTimeRange(secondRange, of: audioTrack, at: CMTimeMakeWithSeconds(10, preferredTimescale: 1)) // 续接第一段
        }

        let playerItem = AVPlayerItem(asset: composition)
        return playerItem
    }
}
