//
//  CrearCuentaViewController.swift
//  GoPlace-Client
//
//  Created by Marcelo on 8/11/21.


import UIKit
import FirebaseAuth
import Photos
import FirebaseFirestore
import FirebaseStorage

class CrearCuentaViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var txtCorreo: UITextField!
    @IBOutlet weak var txtContraseña: UITextField!
    @IBOutlet weak var txtNombres: UITextField!
    
    @IBOutlet weak var fotoPerfil: UIImageView!
    
    var nombreCompletoImg: URL!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtContraseña.isSecureTextEntry = true
    }
    @IBAction func btnSubeFoto(_ sender: Any){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let menu = UIAlertController(title: "Opciones", message: nil, preferredStyle: .actionSheet)
        
        menu.addAction(UIAlertAction(title: "Galería", style: .default, handler:{ (action : UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        menu.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: nil))
        self.present(menu, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo item: [UIImagePickerController.InfoKey : Any]) {
        
        let imagen = item[UIImagePickerController.InfoKey.originalImage] as! UIImage
        fotoPerfil.image = imagen
        
        if let URL = item[UIImagePickerController.InfoKey.imageURL] as? URL{
            nombreCompletoImg = URL
        }
        
        picker.dismiss(animated: true, completion: nil)
    }

 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func subirImagen(urlImagen: URL){
        let almacen = Storage.storage()
        let imagenLocal = urlImagen
        let referencia = almacen.reference()
        let referenciaImagen = referencia.child("img_\(txtCorreo.text ?? "")")
        _ = referenciaImagen.putFile(from: imagenLocal, metadata: nil){(meta, error) in
            guard meta != nil
            else{
                print("error al subir imagen")
                return
            }
        
        }
    }
    
    @IBAction func btnCloseKeyboard(_ sender: Any){
        self.view.endEditing(true)
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
        // Add a new document in collection "cities"
        let db = Firestore.firestore()
        
        db.collection("Usuarios").document(txtCorreo.text ?? "").setData([
            "Contraseña": txtContraseña.text ?? "",
            "Correo": txtCorreo.text ?? "",
            "Nombre": txtNombres.text ?? "",
            "Foto": "img_\(txtCorreo.text ?? "")"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
        subirImagen(urlImagen: nombreCompletoImg)
        
    }
    
    
}
