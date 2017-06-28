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
    @NSManaged var data:Date
    @NSManaged var peso:Float
    @NSManaged var idhistorico:Int32
    @NSManaged var alunos:Set<Aluno>
    
    class func save(moc:NSManagedObjectContext, data:Date, peso:Float, idhistorico:Int32, alunos:Array<Aluno>)->Historico?
    {
        if let novoHistorico = NSEntityDescription.insertNewObject(forEntityName: "Historico", into: moc) as? Historico
        {
            novoHistorico.data = data
            novoHistorico.peso = peso
            novoHistorico.alunos = Set<Aluno>(alunos)
            
            return novoHistorico
        }
        return nil
    }
    
    override var hashValue: Int
    {
        return idhistorico.hashValue
    }
}

