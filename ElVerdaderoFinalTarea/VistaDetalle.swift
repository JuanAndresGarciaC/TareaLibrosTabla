//
//  VistaDetalle.swift
//  ElVerdaderoFinalTarea
//
//  Created by Juan Andres Garcia C on 22/04/17.
//  Copyright © 2017 Juan Andres Garcia C. All rights reserved.
//

import UIKit

class VistaDetalle: UIViewController {
    var codigo = ""
    var libro: libDat = libDat()
    var arregloLi: [libDat] = []
    //var names: [String] = []
    var buscar = false
    
    @IBOutlet weak var titulo: UILabel!
    
    @IBOutlet weak var isbn: UILabel!
    
    @IBOutlet weak var autor8: UILabel!
    
    
    @IBOutlet weak var portada: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Buscar:\(buscar)")
        self.isbn.text = "ISBN: \(libro.isbn)"
        self.titulo.text = "Título: \(libro.titulo)"
        self.autor8.text = "Autor: \(libro.autores)"
        
        self.portada.image = libro.portada

        // Do any additional setup after loading the view.
        
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        arregloLi.append(libro)
        var libros: [libDat] = []
        libros = self.arregloLi
        let sigVista = segue.destination as! TVC
        sigVista.coleccionLibros = arregloLi
        print("Libros:")
        print(libros)
        sigVista.buscart = true
    }
    

}
