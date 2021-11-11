//
//  RecuperarCuentaViewController.swift
//  GoPlace-Client
//
//  Created by Marcelo on 8/11/21.
//
import UIKit
import FirebaseAuth

class RecuperarCuentaViewController: UIViewController {
    
    @IBOutlet weak var txtCorreo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapToClose(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnReturn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRecuperar(_ sender: Any) {
        recuperarClave()
    }
    
    func recuperarClave() {
        
        Auth.auth().sendPasswordReset(withEmail: txtCorreo.text ?? "", completion: {(error) in
            if let error = error {
                
                print("Error al enviar correo de recuperacion => \(error)")
            }
            else{
                self.navigationController?.popViewController(animated: true)
                print("Exito! correo enviado correctamente")
            }
            
        })
        
    }
    
}
