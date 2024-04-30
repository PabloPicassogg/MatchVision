//
//  VideoCellDetail.swift
//  MatchVision
//
//  Created by LoneRunner on 2024/4/29.
//

import SwiftUI
import AVKit
import AVFoundation

struct VideoCellDetail: View {
    let videoPath = "testVideo.mp4"
    var player: AVPlayer
    let xx = 5
    var xxx: Int {
        xx + 5
    }
    
//    init() {
//        if let filePath = Bundle.main.path(forResource: "testVideo", ofType: "mp4") {
//            let url = URL(fileURLWithPath: filePath)
//            let segmentedPlayerItem = videoEditor.createSegmentedVideo(from: url)
//            player = AVPlayer(playerItem: segmentedPlayerItem)
//        } else {
//            print("\(videoPath) not found")
//            player = AVPlayer()
//        }
//    }
    
    var body: some View {
        VStack {
            Text("文瀚").font(.headline)
            Text("廖总").font(.headline)
            VideoPlayer(player: player)
                .frame(height: 200)  // 可以改变视频框大小
        }.background(Color.blue.cornerRadius(10))
    }
}

struct VideoCellDetail_Previews: PreviewProvider {
    static var previews: some View {
        VideoCellDetail()
    }
}
