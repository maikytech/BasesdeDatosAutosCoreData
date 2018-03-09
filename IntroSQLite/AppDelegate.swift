//
//  AppDelegate.swift
//  IntroSQLite
//
//  Created by Maiqui Cedeño on 6/2/16.
//  Copyright © 2016 maikytech. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        copiarDBaDirectorio("buscadorAutos")    //Se llama al metodo copiarDBaDirectorio
        return true
    }
    
    func copiarDBaDirectorio(_ baseDatos:String)
    {
        //Un objeto FileManager permite examinar el contenido del sistema de archivos y realizar cambios en el.
        
        let objetoFileManager = FileManager.default;                             //Se crea objeto Manager.
        let objetoFileHelper = FileHelper()                                                 //Se instancia un objeto de la clase FileHelper.
        let pathDBEnDocumentos = objetoFileHelper.pathArchivoEnCarpetaDocumentos(baseDatos) //Se obtiene el path de la base de datos en caso de que exista.
        let pathDBEnBundle = objetoFileHelper.pathBaseDatosEnBundle(baseDatos)              //Se obtiene el path de la base de datos en el Bundle.
        
        //Pasaremos la base de datos de lugar donde se encuentra en el Bundle hasta la carpeta documentos.
        
        if (objetoFileHelper.existeArchivoEnDocumentos(baseDatos))              //Validamos si existe la base de datos en la carpeta documentos.
        {
            print("\n La base de datos se encuentra con anterioridad en la carpeta de documentos \n")
            
        }else
            {
                do
                {
                    //La funcion copyItemAtPath copia desde un path a otro.
                    try objetoFileManager.copyItem(atPath: pathDBEnBundle, toPath: pathDBEnDocumentos)
                    print("\n Se copio exitosamente la base de datos desde el Bundle hasta la carpeta de documentos \n")
                    
                }catch _            //El simbolo "_" se coloca cuando al catch no se le quieren colocar parametros.
                    {
                        print("\n Error al copiar archivo al directorio de documentos \n")
                    }
            }
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
