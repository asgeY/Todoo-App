//
//  AddToDoView.swift
//  ToDooApp
//
//  Created by Asge Yohannes on 5/23/20.
//  Copyright © 2020 Asge Yohannes. All rights reserved.
//

import SwiftUI

struct AddToDoView: View {
    
    @Environment(\.presentationMode) var presentionMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var name: String = ""
    @State private var priority = "Normal"
    
    let priorities = ["High","Normal","Low"]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    TextField("ToDo", text: $name)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button(action: {
                        if self.name != "" {
                            let toDo = ToDo(context: self.managedObjectContext)
                            toDo.name = self.name
                            toDo.priority = self.priority
                            
                            do {
                                try self.managedObjectContext.save()
                                print("New ToDo : \(toDo.name ?? ""), priority: \(toDo.priority ?? "")")
                            } catch{
                                print(error)
                            }
                        }else {
                            self.errorShowing = true
                            self.errorTitle = "Invaled name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo Item"
                            return
                        }
                        self.presentionMode.wrappedValue.dismiss()
                        
                    }) {
                        Text("Save")
                    }
                }
                Spacer()
            }
            .navigationBarTitle("New ToDo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentionMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                }
            )
                .alert(isPresented: $errorShowing) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
        }
        
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
