//
//  PlayerViewController.swift
//  GinzaGO
//
//  Created by Username on 31.07.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController {

    var urlVideo: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo()

    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }

//    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask{
//        return .all
//    }


    static func route(index: Int) -> PlayerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PlayerViewController")
        let controller = viewController as! PlayerViewController

        let manager = ManagerUrlFile.shared.URLFile

        if index < manager.count {
            controller.urlVideo = manager[index]
        }

        return controller
    }

    private func playVideo() {
        if let url = urlVideo {
            let player = AVPlayer(url: url)
            self.player = player
            player.play()
        }
    }

    private func openArray(urlArray: [URL]) {
        var arrAVPlayerItems = [AVPlayerItem]()
        for obj in urlArray {
            arrAVPlayerItems.append(AVPlayerItem(url: obj))
        }

        let player = AVQueuePlayer(items: arrAVPlayerItems)

        self.player = player
        self.showsPlaybackControls = true
        player.play()
    }
}



