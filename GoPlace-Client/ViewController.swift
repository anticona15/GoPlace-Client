//
//  ViewController.swift
//  GoPlace-Client
//
//  Created by Dianna on 20/10/21.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContra: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtContra.isSecureTextEntry = true
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        validar()
    }
    
    func validar() {
        
        
        Auth.auth().signIn(withEmail: txtCorreo.text ?? "", password: txtContra.text ?? "") { (bien, error) in
            
            if let success = bien, error == nil {
                self.performSegue(withIdentifier: "HomeViewController", sender: nil)
                print("Exito! => \(success)")
            } else {
                print("Error al iniciar session")
            }
            
        }
        
    }

}

