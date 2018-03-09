//
//  ViewController.swift
//  IntroSQLite
//
//  Created by Maiqui Cedeño on 6/2/16.
//  Copyright © 2016 maikytech. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var guardarModelo: UITextField!      //Texfield del modelo a guardar.
    @IBOutlet weak var precio: UITextField!             //Textfield del precio a guardar.
    @IBOutlet weak var buscarModelo: UITextField!       //Texfield del modelo a buscar.
    
    let objetoFileHelper = FileHelper()                 //Instancia de la clase FileHelper.
    var miBaseDatos: FMDatabase? = nil                  //Variable tipo FMDatabase.
    var alert:UIAlertController? = nil                  //Variable tipo UIAlertController.
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Se crea una instancia de la clase FMDatabase, el cual necesita un camino a la base de datos.
        //La funcion "pathArchivoEnCarpetaDocumentos" retorna la ruta completa de un archivo que este dentro de la carpeta de documentos.
        miBaseDatos = FMDatabase(path: objetoFileHelper.pathArchivoEnCarpetaDocumentos("buscadorAutos"))
        
        if(miBaseDatos != nil)
        {
            print("\n Se retorna la ruta completa de la base de datos\n")
        }
    }
    
    @IBAction func guardar(_ sender: UIButton)
    {
        //Si los textfields guardarModelo y precio tienen texto...
        if(guardarModelo.hasText && precio.hasText)
        {
            print("\n Si puedo guardar en mi tabla \n")
            
            iniciarGuardado(guardarModelo.text!, precio: Int(precio.text!)!)        //Se llama a la funcion iniciarGuardado, se hace casting en el parametro precio, de texto a entero.
            
        }else
            {
                
                CrearAlerta(_mensaje: "Por favor ingresar los datos a guardar")
            }
    }
    
    
    @IBAction func buscar(_ sender: UIButton)
    {
        if(buscarModelo.hasText)  //Si el textfield buscarModelo tiene texto...
        {
            print("\n Iniciando busqueda solicitada \n")
            
            iniciarBusqueda(buscarModelo.text!)             //Se llama a la funcion iniciarBusqueda(modelo:String).
            
        }else
            {
                CrearAlerta(_mensaje: "Por favor ingrese los datos a buscar")
            }
    }
    
    func iniciarGuardado(_ modelo:String, precio:Int)
    {
        print("\n Se inicia el guardado de los datos \n")
        
        if(miBaseDatos!.open())
        {
            //Las declaraciones PRAGMA son usadas para modificar algun comportamiento interno de una libreria SQL.
            //La clave o llave primaria es un campo o grupo de campos que identifica en forma unica un registro.
            //La clave foranea es una referenciacion entre dos tablas.
            //executeUpdate retorna un bool si es exitoso, de lo contrario devuelve un nil.
            let foreignKey = "PRAGMA foreign_keys = ON"
            miBaseDatos?.executeUpdate(foreignKey, withArgumentsIn: nil)
            
            //Variable que contiene el Query que inserta los valores de modelo y precio en la base de datos.
            let insertQuerySQL = "INSERT INTO informacion (modelo, precio) VALUES ('\(modelo)', '\(precio)') "
            
            //executeUpdate retorna un bool si es exitoso, de lo contrario devuelve un nil.
            let resultadoDelUpdate = miBaseDatos!.executeUpdate(insertQuerySQL, withArgumentsIn: nil)
            
            if resultadoDelUpdate
            {
                CrearAlerta(_mensaje: "Se agrego el registro en la base de datos correctamente")
                
            }else{
                
                CrearAlerta(_mensaje: "\n Error al insertar los datos: \(miBaseDatos?.lastErrorMessage())")
            }
            
        }else{
            
            CrearAlerta(_mensaje: "No fue posible abrir la base de datos para iniciar guardado")
        }
    }
    
    
    func iniciarBusqueda(_ modelo:String)
    {
        var precioVehiculo:Int32?
        
        if (miBaseDatos!.open())            //Si la base de datos se puede abrir....
        {
            print("\n Si se pudo abrir la base de datos para iniciar la busqueda \n")
            
             let querySQL = "SELECT precio FROM informacion WHERE modelo = '"+modelo+"'"     //Query o solicitud SQlite.
            
            //.executeQuery devuelve un objeto FMResult si la busqueda es exitosa, de lo contrario devuelve nil.
            let resultados:FMResultSet? = miBaseDatos!.executeQuery(querySQL,withArgumentsIn: nil)
            
            while resultados!.next() == true      //.next devuelve true si tenemos algun dato en resultado.
            {
                precioVehiculo = resultados!.int(forColumn: "precio")     //int devuelve un valor entero de la variable resultados.
            }
            
            
            if(precioVehiculo != nil)
            {
                
                CrearAlerta(_mensaje: "El precio del vehiculo es: \(precioVehiculo!)")
                
            }else{
                
                CrearAlerta(_mensaje: "No se encontro la informacion solicitada")
            }

            
            miBaseDatos!.close()            //Cierra la base de datos.
            
        }else
            {
                CrearAlerta(_mensaje: "No se pudo abrir la base de datos")
            }
    }
    
    func CrearAlerta(_mensaje:String)
    {
        
        //Un objeto UIAlertController desplega un aviso o mensaje de alerta.
        alert = UIAlertController(title: "Bienvenido", message: _mensaje, preferredStyle: .alert)
        
        //addAction agrega un objeto de la clase UIAlertAction a una alerta.
        alert?.addAction(UIAlertAction(title: "Continuar", style: .cancel, handler: nil))
        
        //La funcion present configura la presentacion de la alerta.
        present(alert!, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
