//
//  Aluno.swift
//  Personal
//
//  Created by labmacmini17 on 28/06/17.
//  Copyright © 2017 labmacmini17. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Aluno: NSManagedObject
{
    @NSManaged var nome:String
    @NSManaged var idade: Int32
    @NSManaged var altura: Float
    @NSManaged var matricula: Int32


    @NSManaged var historicos: Set<Historico>
    
    
    class func save(moc:NSManagedObjectContext, nome:String, idade:Int32, altura:Float, matricula:Int32,historicos:Array<Historico>)->Aluno?
    {
        if let novoAluno = NSEntityDescription.insertNewObject(forEntityName: "Aluno", into: moc) as? Aluno
        {
            novoAluno.nome = nome
            novoAluno.idade = idade
            novoAluno.altura = altura

            novoAluno.historicos = Set<Historico>()
            
            for aluno in historicos
            {
                novoAluno.historicos.insert(aluno)
            }
            
            novoAluno.save()
            
            return novoAluno
        }
        
        return nil
    }
    
    func delete()
    {
        managedObjectContext?.delete(self)
        self.save()
    }
    
    func save()
    {
        do
        {
            try managedObjectContext?.save()
        }
        catch{}
    }
    
    override var hashValue: Int
    {
        return matricula.hashValue
    }
    
    class func getAll(moc:NSManagedObjectContext)->[Aluno]?
    {
        let request = NSFetchRequest<Aluno>(entityName: "Aluno")
        
        let classificacao = NSSortDescriptor(key: "nome", ascending: true)
        
        request.sortDescriptors = [classificacao]
        
        do
        {
            return try moc.fetch(request)
        }
        catch
        {
        }
        return nil
    }
}
