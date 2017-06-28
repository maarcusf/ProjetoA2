//
//  Historico.swift
//  Personal
//
//  Created by labmacmini17 on 28/06/17.
//  Copyright © 2017 labmacmini17. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class Historico: NSManagedObject
{
    @NSManaged var datamedida:String
    @NSManaged var peso:String
    
    
    @NSManaged var alunos:Set<Aluno>
    
    class func save(moc:NSManagedObjectContext, datamedida:String, peso:String, alunos:Array<Aluno>)->Historico?
    {
        if let novoHistorico = NSEntityDescription.insertNewObject(forEntityName: "Historico", into: moc) as? Historico
        {
            novoHistorico.datamedida = datamedida
            novoHistorico.peso = peso
            novoHistorico.alunos = Set<Aluno>(alunos)
            
            return novoHistorico
        }
        return nil
    }
    
    override var hashValue: Int
    {
        return peso.hashValue
    }
}

