//
//  ContentView.swift
// RandomEffectsRecorder
//
//  Created by koala panda on 2022/11/28.
//

import SwiftUI

struct ContentView: View {
    
    @State var nowRecording = false // これは削除できる
    @State var allowsHisTesthig = true
    @ObservedObject var auidoRecorder = AudioRecorder()
    
    
    var body: some View {
        NavigationView {
            VStack {
                // 録音したファイルリスト表示
                AudioListView()
                    .allowsHitTesting(allowsHisTesthig)
                
                VStack {
                    if !nowRecording {
                        // if auidoRecorder.recording == false{
                        Button (action: {
                            auidoRecorder.record()
                            nowRecording = true
                            allowsHisTesthig = false
                            print("録音")
                            
                        }) {
                            ZStack {
                                Circle()
                                    .stroke(Color("circle") ,lineWidth:3)
                                    .frame(width: 60, height: 60)
                                RoundedRectangle(cornerRadius: 50)
                                    .foregroundColor(.red)
                                    .frame(width: 50, height: 50)
                                    .padding()
                            }
                            
                        }
                        
                    } else {
                        Button (action: {
                            auidoRecorder.recStop()
                            nowRecording = false
                            allowsHisTesthig = true
                            print("ストップ")
                        }) {
                            ZStack {
                                Circle()
                                    .stroke(Color("circle") ,lineWidth:3)
                                    .frame(width: 60, height: 60)
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.red)
                                    .frame(width: 25, height: 25)
                                    .padding(28)
                            }
                            
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("RandomEffects")
            
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
