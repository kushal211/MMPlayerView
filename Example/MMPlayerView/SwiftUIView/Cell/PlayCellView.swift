//
//  PlayCellView.swift
//  MMPlayerView_Example
//
//  Created by Millman on 2019/12/24.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import SwiftUI
import MMPlayerView

struct PlayCellView: View {
    @State var downloadStatus: MMPlayerDownloader.DownloadStatus = .none
    @EnvironmentObject var control: MMPlayerControl
    @EnvironmentObject var playListViewModel: PlayListViewModel

    let obj: DataObj
    let idx: Int
    let showDetailIdx: Int?
    
    var isCurrent: Bool {
        idx == playListViewModel.currentViewIdx
    }

    var body: some View {
        return VStack {
            ZStack {
                Image(uiImage: self.obj.image ?? UIImage())
                    .resizable()
                if isCurrent && showDetailIdx == nil {
                    MMPlayerViewUI(control: self.control, cover: CoverAUI())
                }
            }
            .frame(height: 200)
            .modifier(CellPlayerFramePreference(index: idx))
            HStack {
                Text(self.obj.title)
                    .multilineTextAlignment(.leading)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                Spacer()
                self.generateTopViewFromDownloadStatus().frame(width: 50, height: 50).padding(10)
            }
        }
        .modifier(MMPlayerDownloaderModifier(url: obj.play_Url!, status: $downloadStatus))
    }
    
    func generateTopViewFromDownloadStatus() -> AnyView {
        switch self.downloadStatus {
        case .downloading(let value):
            let percent = String.init(format: "%.2f ％", value*100)
            let view = ZStack {
                ProgressUI(circleWidth: 5)
                .value(Double(value))
                Text(percent).foregroundColor(Color.blue).scaledToFit().padding(5).minimumScaleFactor(0.5)
            }
            return AnyView(view)

        default:
            return AnyView(EmptyView())
        }
    }
}
//
//struct PlayCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayCellView(player: MMPlayerViewUI.init(control: MMPlayerControl()) ,obj: DemoSource.shared.demoData[2], click: <#(CGRect) -> Void#>)
//            .previewLayout(.sizeThatFits)
//    }
//}
//


