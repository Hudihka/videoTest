//
//  VideoPlayerView.swift
//  videoVC
//
//  Created by Username on 19.11.2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit

protocol PlayerDelegate: class{
    func playPayse(_ pressPause: Bool)
    func switched(_ next: Bool)
    func slider(_ value: Float)
}

class VideoPlayerView: UIView {

    @IBOutlet weak var conteinerView: UIView!

    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var slider: UISlider!

    weak var delegate: PlayerDelegate?


    override init (frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }

    private func settingsView() {
        self.conteinerView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        self.conteinerView.addRadius(number: 20)
        self.updateUI(curentTime: 0, maxTime: 0)
    }


    private func xibSetup() {
        conteinerView = loadViewFromNib("VideoPlayerView")
        conteinerView.frame = bounds
        conteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(conteinerView)
    }

    @IBAction func previous(_ sender: UIButton) {
        self.delegate?.switched(false)
    }

    @IBAction func next(_ sender: UIButton) {
        self.delegate?.switched(true)
    }

    @IBAction func playPause(_ sender: UIButton) {
        let pressPause = (sender.titleLabel?.text ?? "pause") == "pause"
        let newText = pressPause ? "play" : "pause"
        sender.setTitle(newText, for: .normal)

        self.delegate?.playPayse(pressPause)

    }

    @IBAction func sliderAction(_ sender: UISlider) {

        self.delegate?.slider(sender.value)
    }

    //label

    func updateUI(curentTime: Double, maxTime: Double){

        if curentTime.isNaN || maxTime.isNaN {
            return
        }

        self.slider.setValue(Float(curentTime/maxTime), animated: true)

        let intCurrent = Int(curentTime)
        let intMax = Int(maxTime)

        let maxSeconds      = intMax % 60
        let maxMin          = intMax / 60

        let curentSeconds   = intCurrent % 60
        let curentMin       = intCurrent / 60

        let strMax          = "\(maxMin.timeStr):\(maxSeconds.timeStr)"
        let strCurent       = "\(curentMin.timeStr):\(curentSeconds.timeStr)"

        self.labelTime.text = strCurent + " / " + strMax

    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension Int{

    var timeStr: String {
        let str = self > 9 ? "" : "0"
        return "\(str)\(self)"
    }



}
