//
//  ViewController.swift
//  MP3Experiment
//
//  Created by manish on 27/09/15.
//  Copyright © 2015 manish. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var isPlaying = false
    //var timer:NSTimer!
    var elapsedTime : Int = 0
    var timer : Timer!;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let utiString: String = AVFileTypeMPEGLayer3
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: NSURL (fileURLWithPath: NSBundle.mainBundle().pathForResource("mp3", ofType: "mp3")!), fileTypeHint:utiString)
        } catch {
            print("MP3 Not found.")
            //Handle the error
        }
        
        handleSetAction()
    }
    
    /**
    This method is triggered after the user hits 'Set' to set a countdown timer to run, create a timer, update the label to indicate the time set by the user in the dialog
    :param: an action indicating the choice taken by the user
    */
    private func handleSetAction () -> (){
        
            let eventDate = NSDate(dateString:"2015-11-30T12:00")
            let eventInterval = eventDate.timeIntervalSince1970
            let currentInterval = NSDate().timeIntervalSince1970
            let duration = Int(eventInterval-currentInterval)
            
            //Initialize the timer to run for the amount of seconds specified in the above step and update the label with the amount of remaining time
            timer = Timer(duration: duration ){
                //the handler or callback which is triggered each time the timer 'ticks'
                (elapsedTime: Int) -> () in
                
                //remaining time in seconds = total duration in seconds - elapsed time in seconds
                let difference = duration - elapsedTime;
                self.countDown(difference)
                
                if difference == 0 {
                 print("done")
                }
            }
            timer.start();
        
    }

    
    @IBOutlet weak var playButton: UIButton!
    let stopImg = UIImage(named: "stop.png") as UIImage!
    let playImg = UIImage(named: "play.png") as UIImage!

    
    @IBAction func playBtn(sender: AnyObject) {
        audioPlayer.prepareToPlay()
        
        if isPlaying {
            audioPlayer.pause()
            isPlaying = false
            playButton.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
            
        } else {
            audioPlayer.play()
            playButton.setImage(UIImage(named: "stop.png"), forState: UIControlState.Normal)
            isPlaying = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var changeSec: UILabel!
    @IBOutlet weak var changeMin: UILabel!
    @IBOutlet weak var changeHour: UILabel!
    @IBOutlet weak var changeDays: UILabel!

    func countDown(difference : Int){
        
        let totalInterval : Int = difference
        
        let days = Int(totalInterval)/86400
        let hours = (Int(totalInterval)-(days*86400))/3600
        let minutes = (Int(totalInterval)-((days*86400)+(hours*3600)))/60
        let seconds = (Int(totalInterval)%60)
        changeSec.text = String(seconds)
        changeMin.text = String(minutes)
        changeHour.text = String(hours)
        changeDays.text = String(days)
        
    }
    
}

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd\'T\'HH:mm"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
}



