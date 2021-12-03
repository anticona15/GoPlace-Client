//
//  HomeViewController.swift
//  GoPlace-Client
//
//  Created by Marcelo on 3/12/21.
//

import UIKit
import FirebaseStorage
import FirebaseStorageUI

class HomeViewController : UIViewController{
    
    @IBOutlet weak var imgprofile : UIImageView!
    
    
    var obj : Usuario!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyles()
     cargarDataUsuario()
        
    }
    
    func cargarDataUsuario(){
        let imagen = obj.Foto
        let reference = Storage.storage().reference().child(imagen)
        imgprofile.sd_setImage(with: reference)
    }
    
    func setStyles(){
        imgprofile.layer.cornerRadius = imgprofile.frame.size.width / 2
        imgprofile.clipsToBounds = true
    }
    
}

