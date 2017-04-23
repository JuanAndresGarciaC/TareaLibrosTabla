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
        if buscar == true{
            print("si avanzó")
            let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
            //https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7
            let codigo = arregloLi[0].isbn
            libro.isbn = codigo
            print("Codigo:\(libro.isbn)")
            let url = NSURL(string: urls + codigo)
            let datos = NSData(contentsOf: url! as URL)
            do{
                let json = try JSONSerialization.jsonObject(with: datos as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
                let dico = json as! NSDictionary
                let dico1 = dico["ISBN:" + codigo] as! NSDictionary
                let dico2 = dico1["authors"] as! NSArray
                print(dico2)
                let autor1 = dico2.object(at: 0) as! NSDictionary
                let autor2 = autor1["name"] as! String
                
                print("VD:\(autor2)")
                
                //let autor = autor1["name"] as! String
                
                /*for index in 0...autor1.count-1 {
                    
                    let nombre = autor1[index] as! [String : AnyObject]
                    
                    //names.append(nombre["name"] as! String)
                    
                }
                */
                //libro.autores = names
                
                
                let dico3 = dico1["title"] as! String
                libro.titulo = dico3
                if let port = dico1["cover"] as? [String : AnyObject] {
                    if let imagen = port["small"] as? String {
                        let urlImagen = URL(string: imagen)
                        let dataImagen = try? Data(contentsOf: urlImagen!)
                        var image = UIImage(data: dataImagen!)
                        libro.portada = image
                        
                    }
                }else{
                    libro.portada = nil
                }
                libro.autores = autor2
            }catch _ {
                
            }
            
        }
        self.isbn.text = "ISBN: \(libro.isbn)"
        self.titulo.text = "Título: \(libro.titulo)"
        self.autor8.text = "Autor: \(libro.autores)"
        //self.autor.reloadData()
        self.portada.image = libro.portada

        // Do any additional setup after loading the view.
        
    }
   /* public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = names[indexPath.row]
        self.names.removeAll()
        return(cell)
    }
 */
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
