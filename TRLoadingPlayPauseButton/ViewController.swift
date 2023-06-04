//
//  ViewController.swift
//  TRLoadingPlayPauseButton
//
//  Created by BCL-Device-11 on 4/6/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playPauseButton: TRLoadingButton!
    
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func tappedOnPlayPauseButton(_ sender: TRLoadingButton) {
        if player?.rate == 1 {
            playPauseButton.isSelected = false
            player?.pause()
        } else {
            playPauseButton.isSelected = true
            if player == nil {
                playPauseButton.isLoading = true
                configurePlayer()
                player?.play()
            } else {
                player?.play()
            }
        }
    }
    
    func configurePlayer() {
        let audioURL = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3")!
        playerItem = AVPlayerItem(url: audioURL)
        player = AVPlayer(playerItem: playerItem)
        
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    @objc func playerDidFinishPlaying() {
        playPauseButton.isSelected = false
        player?.seek(to: CMTime.zero)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "status",
              let playerItem = object as? AVPlayerItem else {
            return
        }
        
        if playerItem.status == .readyToPlay {
            playPauseButton.isLoading = false
            
        } else if playerItem.status == .failed {
            playPauseButton.isLoading = false
            print("Error loading audio: \(playerItem.error?.localizedDescription ?? "")")
        }
    }
}

