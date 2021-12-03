//
//  ViewController.swift
//  GoPlace-Client
//
//  Created by Dianna on 20/10/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class ViewController: UIViewController {
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContra: UITextField!
    @IBOutlet weak var btnRecordar: UIButton!
    
    var recuerda = false{
        didSet{self.actualizarBtnRecordar()}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if let controller = segue.destination as? HomeViewController,let objUsuario = sender as? Usuario{
            controller.obj = objUsuario
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtContra.isSecureTextEntry = true
    }
    
    @IBAction func btnRecordar(_ sender:Any) {
        self.recuerda = !self.recuerda
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        validar()
    }
    
    func validar() {
        
        Auth.auth().signIn(withEmail: txtCorreo.text ?? "", password: txtContra.text ?? "") { (bien, error) in
            
            if let success = bien, error == nil {
                
                let db = Firestore.firestore()
                
                db.collection("Usuarios").document(self.txtCorreo.text ?? "").getDocument{(infoDocument,error) in
                    if let document = infoDocument, error == nil{
                        
                        let obj = Usuario(correo: document.get("Correo") as! String, nombre: document.get("Nombre") as! String , contraseña: document.get("Contraseña")as! String, foto: document.get("Foto")as! String)
                    
                        self.performSegue(withIdentifier: "HomeViewController", sender: obj)
                        print("Exito! => \(success)")

                    }
                }
                
                            } else {
                print("Error al iniciar session")
            }
            
        }
        
    }
    
    
    
    func actualizarBtnRecordar(){
        self.btnRecordar.isChecked(recuerda)
    }
}

