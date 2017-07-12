//
//  ViewController.swift
//  InstaDownloader
//
//  Created by adm on 5/3/17.
//  Copyright © 2017 JeguLabs. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController,UITextFieldDelegate ,GADBannerViewDelegate, GADInterstitialDelegate {

    //Outlets
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var myBanner0: GADBannerView!
    @IBAction func showAdInt(_ sender: Any) {
        
        if self.intersticalAd.isReady {
            self.intersticalAd.present(fromRootViewController: self)
        } else {
            print("No funca")
        }
 
    }
   
    //Instancias Banner Instertical
    var intersticalAd : GADInterstitial!
    
    func reloadIntersticalAd() -> GADInterstitial {
        
        let interstical = GADInterstitial(adUnitID: "ca-app-pub-5472460153263316/8377419181")
        interstical.delegate = self
        interstical.load(GADRequest())
        return interstical
        
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.intersticalAd = reloadIntersticalAd()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate TextField
        textField.delegate = self
        
        //Gesture
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        //Background 
        self.view.backgroundColor = UIColor.white
        
        //Timer
        Timer.scheduledTimer(timeInterval: 75, target: self, selector: #selector(ViewController.showAdInt(_:)), userInfo: nil, repeats: true)
        
        //Banner Estatico abajo
        
        myBanner0.adUnitID = "ca-app-pub-5472460153263316/9409303983"
        myBanner0.rootViewController = self
        myBanner0.load(GADRequest())
        
        //Banner Interstical boton
        self.intersticalAd = GADInterstitial(adUnitID: "ca-app-pub-5472460153263316/8377419181")
        let request = GADRequest()
        request.testDevices = ["2077ef9a63d2b398840261c8221a0c9b"]
        self.intersticalAd.load(request)
        self.intersticalAd = reloadIntersticalAd()
        
        
        
    }


    //Segue <--------------------------------------------->
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ViewImage" {
        
        
            
            let vc = segue.destination as! VistaImagenCompletaURL
            vc.urlImage = "https://api.instagram.com/oembed/?url=\(textField.text!)"
            
    }
    }
    
    

    
    
    //Open Instagram (Only Safari)
    @IBAction func openInstagram(_ sender: Any) {
        
        let instagramHooks = "instagram://"
        let instagramUrl1 = NSURL(string: instagramHooks)
        
        if UIApplication.shared.canOpenURL(instagramUrl1! as URL)
        {
            UIApplication.shared.openURL(instagramUrl1! as URL)
        } else {
            UIApplication.shared.openURL(NSURL(string: "https://instagram.com/")! as URL)
        }
        
        
    }
    
    
    
    //Dismiss Keyboard
    func dismissKeyboard() {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

