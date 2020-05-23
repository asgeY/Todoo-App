//
//  ContentView.swift
//  ToDooApp
//
//  Created by Asge Yohannes on 5/23/20.
//  Copyright © 2020 Asge Yohannes. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: ToDo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ToDo.name
        , ascending: true)]) var todos: FetchedResults<ToDo>
    
    @State private var showAddToDoView: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "UnKnown")
                        }
                    }
                    .onDelete(perform: deleteToDo)
                }
                .navigationBarTitle("ToDo", displayMode: .inline)
                .navigationBarItems(leading: EditButton(), trailing:
                    Button(action: {
                        self.showAddToDoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showAddToDoView) {
                        AddToDoView()
                            .environment(\.managedObjectContext, self.managedObjectContext)
                    }
                )
                if todos.count == 0 {
                    EmptyListView()
                }
            }
        }
    }
    private func deleteToDo (at offsets: IndexSet){
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
        
    }
}
