//
//  CrearCuentaViewController.swift
//  GoPlace-Client
//
//  Created by Marcelo on 8/11/21.


import UIKit
import FirebaseAuth

class CrearCuentaViewController: UIViewController {
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContraseña: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtContraseña.isSecureTextEntry = true
    }
    
    @IBAction func btnReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCrearCuenta(_ sender: Any) {
        registrar()
    }
    
    func registrar() {
        
        Auth.auth().createUser(withEmail: txtCorreo.text ?? "", password: txtContraseña.text ?? "") { (bien, error) in
            
            if let success = bien, error == nil {
                self.navigationController?.popViewController(animated: true)
                print("se registro el usuario correctamente => \(success)")
            
            } else {
                print("error al registrar usuario")
            }
        }
        
    }
    
}
