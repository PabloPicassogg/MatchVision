//
//  videoCell.swift
//  MatchVision
//
//  Created by LoneRunner on 2024/4/29.
//

import SwiftUI
import AVKit

struct videoCell: View {
    var body: some View {
        VStack {
            Text("文瀚").font(.headline)
            Text("廖总").font(.headline)
            Rectangle().fill(Color.white.opacity(0)) // 填充红色
                                .frame(height: 100) // 设置适当的高度
        }.background(Color.blue.cornerRadius(10))
    }
}

struct videoCell_Previews: PreviewProvider {
    static var previews: some View {
        videoCell()
    }
}
