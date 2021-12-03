//
//  Usuario.swift
//  GoPlace-Client
//
//  Created by Marcelo on 3/12/21.
//

import UIKit

class Usuario{
    var Correo = ""
    var Nombre = ""
    var Contraseña = ""
    var Foto = ""
    
    init(correo:String,nombre:String,contraseña:String,foto:String){
        self.Correo = correo
        self.Contraseña = contraseña
        self.Nombre = nombre
        self.Foto = foto
    }

}
