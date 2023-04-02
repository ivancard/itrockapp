//
//  SplashViewController.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/12/2022.
//

import UIKit
import AVKit

final class SplashViewController: BaseViewController {
    
    @IBOutlet weak var videoContainer: UIView!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var playerLayer = AVPlayerLayer()
        guard let url = Bundle.main.url(forResource: "splashVideo", withExtension: ".mp4") else {return}
        let player = AVPlayer(playerItem: AVPlayerItem(asset: AVAsset(url: url), automaticallyLoadedAssetKeys: ["playable"]))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoContainer.layer.addSublayer(playerLayer)
        playerLayer.frame = videoContainer.bounds
        playerLayer.player?.play()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {

            if User.current == nil {
                let vc = LoginViewController()
                let nc = UINavigationController(rootViewController: vc)
                NavigationHelper.setRoot(viewController: nc, animated: true)
            } else {
                NavigationHelper.enterApp()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
}
