//
//  FileHelper.swift
//  Created by Juan on 6/6/16.
//  Copyright © 2016 Juan Villalvazo. All rights reserved.
//

import Foundation

class FileHelper
{
    //Un objeto FileManager permite examinar el contenido del sistema de archivos y realizar cambios en él.
    let objetoFileManager = FileManager.default


    //Retorna la ruta de la carpeta de documentos de la app.
    func pathCarpetaDocumentos() -> String
    {
        /* NSSearchPathForDirectoriesInDomains devuelve un array tipo string con una lista de rutas de busqueda en los directorios especificados en los dominios especificados, los parametros de esta funcion son: 
         1. NSSearchPathDirectory.DocumentDirectory es un objeto tipo enumeracion, cuyos valores indican el directorio de interes, en este caso DocumentDirectory (caso 9).
         2. NSSearchPathDomainMask tambien es un objeto tipo enumeracion que indica el dominio que nos interesa, en este caso es "UserDomainMask", el cual es el directorio raiz del usuario, el lugar para instalar items personales.
         3. El parametro expandTilde indica si expandir la tilde (~) en los directorios retornados, en este caso es true, esto es una abreviacion de la ruta cuya parte principal se reemplaza por una tilde.
         
         [0] indica el primer path del array.   */
 
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        return documentsFolderPath
    }

    //Retorna la ruta completa de un archivo que este dentro de la carpeta de documentos
    func pathArchivoEnCarpetaDocumentos(_ nombreArchivo: String) -> String
    {
        
        //pathCarpetaDocumentos() as NSString significa que a el valor de retorno de la funcion pathCarpetaDocumentos() se represente como un NSString.
        // appendingPathComponent es una funcion de instancia de la clase NSURL, que agrega un componente a una ruta y la retorna, su parametro es un string.
        return (pathCarpetaDocumentos() as NSString).appendingPathComponent(nombreArchivo)
    }

    //Revisa si existe o no un archivo en el directorio de documentos
    func existeArchivoEnDocumentos(_ nombreArchivo: String) -> Bool
    {
        var existe:Bool?
    
        if (objetoFileManager.fileExists(atPath: pathArchivoEnCarpetaDocumentos(nombreArchivo)))
        {
            print("\n El archivo \(nombreArchivo) existe en el path de documentos \n.");
            existe = true
        }
        else
        {
            print("El archivo \(nombreArchivo) No existe en el path de documentos.");
            existe = false
        }
    
        return existe!
    }

    //Data Base

    func pathBaseDatosEnBundle(_ nombreBaseDatos: String) -> String
    {
        let path = Bundle.main.path(forResource: nombreBaseDatos, ofType:"sqlite")
        
        if path == nil {
            print("No existe el archivo solicitado en el Bundle \n")
        }else{
            print("Si existe el archivo solicitado en el Bundle \n")
        }
        return path!
    }

    func dbExisteEnBundle(_ nombreBaseDatos: String) -> Bool
    {
        var valor:Bool?
    
        if ((Bundle.main.path(forResource: nombreBaseDatos, ofType:"sqlite")) != nil)
        {
            print("El archivo solicitado si existe en el bundle");
            valor = true
        }
        else
        {
            print("El archivo solicitado no existe en el bundle");
            valor = false
        }
    
        return valor!
    }
}
