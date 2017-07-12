//
//  VistaImagenCompletaURL.swift
//  InstaDownloader
//
//  Created by adm on 5/18/17.
//  Copyright © 2017 JeguLabs. All rights reserved.
//

import UIKit
import SDWebImage


class VistaImagenCompletaURL: UIViewController {

    //Outlets
    @IBOutlet weak var imageView: UIImageView!
    //Vars
    var urlImage = String() //"https://api.instagram.com/oembed/?url=https://www.instagram.com/p/5IjD3rJnc4/?taken-by=_omgitschuy"
    var urlDownload = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        //Content image
        self.imageView.contentMode = .scaleAspectFill
        
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
                            
                            //self.imageView.sd_setImage(with: URL(string: self.urlDownload))
                            self.imageView.sd_setImage(with: URL(string: self.urlDownload), placeholderImage: UIImage(named: "PleaseWait"))
                            
                            
                            
                           /* if let url = NSURL(string: urlInstagram as! String),
                                let data = NSData(contentsOf: url as URL)
                            {
                                self.imageView.image = UIImage(data: data as Data)
                                
                            }
                            else {
                                print ("Error")
                            }
                            */
                            
                        }
                    }
                        
                    catch {
                        
                    }
                }
                
            }
        }
        task.resume()
        
        
        

        
    }



    @IBAction func savePhoto(_ sender: Any) {
        let imageData = UIImagePNGRepresentation(imageView.image!)
        let compresedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "The image has been saved.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
