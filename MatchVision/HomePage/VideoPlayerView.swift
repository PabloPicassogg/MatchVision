//
//  VideoPlayerView.swift
//  MatchVision
//
//  Created by LoneRunner on 2024/4/29.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @StateObject private var videoPlayer: VideoPlayerWrapper

    var timeRanges: [(CMTime, CMTime)]    // 存放起止时间段的数组
    
    init(url: URL, timeRanges: [(CMTime, CMTime)]) {
        self.timeRanges = timeRanges
        _videoPlayer = StateObject(wrappedValue: VideoPlayerWrapper(url: url, timeRanges: timeRanges))
    }
    
    var body: some View {
        VideoPlayer(player: videoPlayer.player)
            .onAppear {
                videoPlayer.play()
            }
            .onDisappear() {
                videoPlayer.pause()
            }
    }
}

class VideoPlayerWrapper: ObservableObject {
    let player: AVPlayer
    
    var timeRanges: [(CMTime, CMTime)]
    
    init(url: URL, timeRanges: [(CMTime, CMTime)]) {
        self.timeRanges = timeRanges
        let videoAsset = AVURLAsset(url: url)
        let videoPlayerItem = AVPlayerItem(asset: videoAsset)
        self.player = AVPlayer(playerItem: videoPlayerItem)
        
        self.setupVideoPlayback()
    }
    
    func setupVideoPlayback() {
        var observationTimes = [NSValue]()
        for timeRange in timeRanges {
            let endTime = timeRange.1
            observationTimes.append(NSValue(time: endTime))
        }
        player.addBoundaryTimeObserver(forTimes: observationTimes, queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            self.player.pause()
            if let nextTimeRange = self.timeRanges.first(where: { $0.0 > self.player.currentTime() }) {
                let nextStartTime = nextTimeRange.0
                self.player.seek(to: nextStartTime)
                self.player.play()
            }
        }
    }
    
    func play() {
        player.seek(to: timeRanges[0].0)
        player.play()
    }
    
    func pause() {
        player.pause()
    }
}
