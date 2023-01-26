//
//  ContentView.swift
//  wesplit
//
//  Created by user on 15.12.2022..
//
import UIKit
import SwiftUI

struct ContentView: View {
   
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 0
    @State private var tip = 10
    @FocusState private var amountIsFocused : Bool
    
    let tipAmount = [0,10,15,20,100]
    
    var amountPerPerson: Double{
        let peopleCount = Double(numOfPeople+2)
        let tipPercent = Double(tip)
        
        let tipAmount = checkAmount / 100 * tipPercent
        let totalAmount = checkAmount + tipAmount
        let totalPerPerson = totalAmount / peopleCount
        
        return totalPerPerson
    }
    
    var totalAmount: Double{

        let tipPercent = Double(tip)
        let tipAmount = checkAmount / 100 * tipPercent
        return checkAmount + tipAmount
    }
    
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value:$checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(.green)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                
                    Picker("People sharing the bill:", selection: $numOfPeople){
                        ForEach(2..<11){
                            Text(" \($0) people")
                                .foregroundColor(.indigo)
                        }
                    }.foregroundColor(.gray)
                    
                }
                
                Section("Select the tip amount"){
                    Picker("Tip Amount", selection: $tip){
                        ForEach(tipAmount, id: \.self){
                            Text($0, format: .percent)
                                
                        }
                    }.pickerStyle(.segmented)
                                
                    
                }
                Section("Total amount"){
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(.black)
                }
                Section("Each should pay"){
                    Text(amountPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(.red)
                }
                
            }
            
            .navigationTitle("Split the bill")
            
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
            
            
            
        }
        

    }
}
            

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
