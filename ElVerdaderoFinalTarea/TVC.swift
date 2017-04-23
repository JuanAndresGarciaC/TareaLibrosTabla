//
//  TVC.swift
//  ElVerdaderoFinalTarea
//
//  Created by Juan Andres Garcia C on 22/04/17.
//  Copyright © 2017 Juan Andres Garcia C. All rights reserved.
//

import UIKit
struct libDat {
    var isbn: String
    var titulo: String
    var autores: String
    var portada: UIImage?
    
    init() {
        isbn = ""
        titulo = ""
        autores = ""
        portada = nil
    }
}
class TVC: UITableViewController {
    var libros : Array<Array<String>> = [["Cien años de soledad","978-84-376-0494-7"]]
        
    
    @IBOutlet weak var texto: UITextField!
    
    
    var buscart = false
    
    var coleccionLibros: [libDat] = []
    
    var aux: libDat = libDat()
    var auttores: [String] = []
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OpenLibrary" //Cambia nombre que aparecen en la flechitas de ir hacia atras
        print("Libros en TVC: \(coleccionLibros)")
       
        if buscart == true{
        let cc = self.coleccionLibros[0].isbn
        print("Lo siguiente es el elemento self.coleccionLibros[0].isbn:")
        print(cc)
            libros.append([coleccionLibros[0].titulo,coleccionLibros[0].isbn])
            buscart = false
        }
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(buscar(_:)))
        
        navigationItem.leftBarButtonItem = addButton
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    func buscar(_ sender: UIButton) {
        buscart = true
      
        
        
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "showDetails", sender: self)
        }
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.coleccionLibros.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
cell.textLabel?.text = self.libros[indexPath.row][0]
        // Configure the cell...
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let destinaciondestination = segue.destination as! VistaDetalle
        if segue.identifier == "showDetails" {
         //  if let indexPath = tableView.indexPathForSelectedRow {
                /*let object = fetchedResultsController.object(at: indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                */
                let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
                //https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7
                let codigo = texto.text!
            print(codigo)
                aux.isbn = codigo
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
                    aux.autores = autor2
                    print(autor2)
                    /*for index in 0...autor1.count-1 {
                        print(index)
                        let nombre = autor1[index] as! [String : AnyObject]
                        
                        auttores.append(nombre["name"] as! String)
                        
                    }
 
                    aux.autores = auttores
                    */
                    
                    let dico3 = dico1["title"] as! String
                    aux.titulo = dico3
         
                 if let port = dico1["cover"] as? [String : AnyObject] {
                        if let imagen = port["small"] as? String {
                            let urlImagen = URL(string: imagen)
                            let dataImagen = try? Data(contentsOf: urlImagen!)
                            var image = UIImage(data: dataImagen!)
                            aux.portada = image
                            
                        }
                    }else{
                        aux.portada = nil
                    }
 
                }catch _ {
                    
                }
            //}
            
           // destinaciondestination.names = aux.autores
            destinaciondestination.libro.isbn = aux.isbn
            destinaciondestination.libro.titulo = aux.titulo
            destinaciondestination.libro.portada = aux.portada
            destinaciondestination.libro.autores = aux.autores
                libros.append([aux.titulo, aux.isbn])
            buscart = false
            
            var libroz: [libDat] = []
            libroz = self.coleccionLibros
            
            destinaciondestination.arregloLi = libroz
        }else if segue.identifier != "showDetails" {
            buscart = true
            let ip = self.tableView.indexPathForSelectedRow// nos va a decir el renglon de lo seleccionado
            destinaciondestination.codigo = self.libros[ip!.row][1]
            print(self.libros[ip!.row][1])
            destinaciondestination.buscar = buscart
            destinaciondestination.arregloLi = coleccionLibros
        }
        
    }
 
    
    

}
