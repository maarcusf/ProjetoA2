//
//  UsuarioViewController.swift
//  Personal
//
//  Created by Marcus Ferreira on 28/06/17.
//  Copyright © 2017 labmacmini17. All rights reserved.
//

import Foundation
import UIKit

class UsuarioViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var vrTableView: UITableView!
    @IBOutlet weak var vrCampoMatricula: UITextField!
    @IBOutlet weak var vrCampoNome: UITextField!
    @IBOutlet weak var vrIdade: UITextField!
    @IBOutlet weak var vrAltura: UITextField!
    
    var aluno:Aluno?

    @IBAction func adicionarHistorico(_ sender: Any) {
        
        let alert = UIAlertController(title: "Histórico", message: "Deseja inserir um novo peso?", preferredStyle: .alert)

        alert.addTextField
            { (vrTextField) in
                vrTextField.keyboardType = .default
                vrTextField.placeholder = "Data"
        }
        
        alert.addTextField
            { (vrTextField) in
                vrTextField.keyboardType = .default
                vrTextField.placeholder = "Peso"
        }

        alert.addAction(UIAlertAction(title: "Confirmar", style: .default, handler:
            { (action) in
                let historico = Historico.save(moc: managedObjectContext, datamedida: (alert.textFields?[0].text)!, peso: (alert.textFields?[1].text)!, alunos: [Aluno]())
                self.aluno?.historicos.insert(historico!)
                self.aluno?.save()
                self.vrTableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler:nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return aluno?.historicos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let celula = vrTableView.dequeueReusableCell(withIdentifier: "celula_aluno")
        
        let arrayHistoricos = Array(aluno!.historicos)
        
        celula?.textLabel?.text = arrayHistoricos[indexPath.row].datamedida
        
        celula?.detailTextLabel?.text = arrayHistoricos[indexPath.row].peso
        
        return celula!
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        if (vrCampoNome?.text!.isEmpty)! || vrCampoMatricula?.text! == "0"
        {
            aluno?.delete()
            return
        }
        
        if aluno?.nome != vrCampoNome?.text
        {
            aluno?.nome = (vrCampoNome?.text)!
            aluno?.save()
        }
        
        if aluno?.matricula != Int32(vrCampoMatricula.text!)!
        {
            aluno?.matricula = Int32(vrCampoMatricula.text!)!
            aluno?.save()
        }
        
        if aluno?.idade != Int32(vrIdade.text!)!
        {
            aluno?.idade = Int32(vrIdade.text!)!
            aluno?.save()
            
        }
        
        if aluno?.altura != Float(vrAltura.text!)!
        {
            aluno?.altura = Float(vrAltura.text!)!
            aluno?.save()
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("carregado")
        vrTableView.delegate = self
        vrTableView.dataSource = self
        if let aluno = self.aluno
        {
            vrCampoNome.text = aluno.nome
            vrCampoMatricula.text = String(aluno.matricula)
            vrIdade.text = String(aluno.idade)
            vrAltura.text = String(aluno.altura)
            
        }
    }


    
    }





