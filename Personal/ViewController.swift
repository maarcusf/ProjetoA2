//
//  ViewController.swift
//  Personal
//
//  Created by labmacmini17 on 28/06/17.
//  Copyright © 2017 labmacmini17. All rights reserved.
//

import UIKit

let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var vrTableView: UITableView!
    var alunos = [Aluno]()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ver_usuario"
        {
            let tela = segue.destination as! UsuarioViewController
            
            tela.aluno = alunos[(vrTableView.indexPathForSelectedRow?.row)!]
        }
        
        if segue.identifier == "adicionar_usuario"
        {
            let tela = segue.destination as! UsuarioViewController
            
            tela.aluno =  Aluno.save(moc: managedObjectContext, nome: "", idade: 0, altura:0.0, matricula: 0, historicos: [Historico]())
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            alunos[indexPath.row].delete()
            alunos = Aluno.getAll(moc: managedObjectContext)!
            vrTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Lista de Alunos"
        vrTableView.dataSource = self
        vrTableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        alunos = Aluno.getAll(moc: managedObjectContext)!
        vrTableView.reloadData()
    }
    
    //**********IMPLEMENTACAO DE DATASOURCE*******/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alunos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = vrTableView.dequeueReusableCell(withIdentifier: "celula")
        
        celula?.textLabel?.text = alunos[indexPath.row].nome
        celula?.detailTextLabel?.text = String(alunos[indexPath.row].matricula)
        
        return celula!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

