//
//  DetailsViewController.swift
//  MusicApp
//
//  Created by Madan on 08/11/18.
//  Copyright © 2018 TCS. All rights reserved.
//

import UIKit
import AVFoundation

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var mediumImageView: UIImageView!
    
    var tuneDataSource:Tune?
    var selectedIndex:Int = 0
    var player = AVAudioPlayer()

    @IBAction func gotoGridView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func playSong(_ sender: Any) {
        
        if let obj =  tuneDataSource?.data?[selectedIndex]{
            let urlstring = obj.preview!
            let url = URL(string: urlstring)
            downloadFileFromURL(url: url!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("selectedIndex", selectedIndex)
        
        if let obj =  tuneDataSource?.data?[selectedIndex]{
            self.movieTitle.text = obj.title!
            self.mediumImageView.image = UIImage(named: "defaultImage")
            let url = URL(string: obj.album!.coverMedium!)
            DispatchQueue.global().async {
                if let url = url{
                    let data = try? Data(contentsOf: url)
                    if let data = data{
                        DispatchQueue.main.async {
                            self.mediumImageView.image = UIImage(data: data)
                        }
                    }
                }else{
                    print("URL does not exists")
                }
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    func downloadFileFromURL(url:URL){
        
        var downloadTask:URLSessionDownloadTask
        downloadTask =  URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
            self!.play(url: URL!)
        })
        downloadTask.resume()
    }
    
    func play(url:URL) {
        print("playing \(url)")
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player.prepareToPlay()
            player.volume = 1.0
            player.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
    }
}
