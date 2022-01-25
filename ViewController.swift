import UIKit
import AVFoundation
class ViewController: UIViewController {
    let eggTimes = ["Soft": 3 ,"Medium": 5 ,"Hard": 7]
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    var timer = Timer()
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime{
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            secondsPassed += 1
        }
        else{
            timer.invalidate()
            titleLabel.text = "DONE!!"
            progressBar.progress = 1
            self.playSound(title: "alarm_sound")
        }
    }
    func playSound(title: String?) {
            let url = Bundle.main.url(forResource: title, withExtension: "mp3")
            player = try!AVAudioPlayer(contentsOf: url!)
            player.play()
    }
}
