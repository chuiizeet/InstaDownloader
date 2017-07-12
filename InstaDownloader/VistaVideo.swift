//
//  VistaVideo.swift
//  InstaDownloader
//
//  Created by adm on 6/10/17.
//  Copyright © 2017 JeguLabs. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MobileCoreServices

class VistaVideo: UIViewController {

    //Vars
    var urlImage = String() //"https://api.instagram.com/oembed/?url=https://www.instagram.com/p/5IjD3rJnc4/?taken-by=_omgitschuy"
    var urlDownload = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Content image
       // self.imageView.contentMode = .scaleAspectFill
        
        let url = URL(string: urlImage)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print("Error JSON")
            } else {
                if let content = data
                {
                    do {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        //print(myJson)
                        
                        if let urlInstagram = myJson["thumbnail_url"] {
                            print(urlInstagram!)
                            self.urlDownload = urlInstagram as! String
                            
                            //NSURL Image
                            
                           
                          //  self.imageView.sd_setImage(with: URL(string: self.urlDownload), placeholderImage: UIImage(named: "PleaseWait"))
                            
                            
                                                      
                        }
                    }
                        
                    catch {
                        
                    }
                }
                
            }
        }
        task.resume()
        
        
       
        
        
    }


    
    
    
      
    }
    

