//
//  AudioListView.swift
//  RandomEffectRecorder
//
//  Created by koala panda on 2022/11/29.
//
import SwiftUI

struct AudioListView: View {
    
    var recordedAudio = RecordedAudio()
    var body: some View {
        List {
            ForEach(recordedAudio.audioDatas(), id: \.self) { recording in
                RecordingRow(recURL: recording)
            }
            .onDelete(perform: delete)
        }
    }
    func delete(offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(recordedAudio.recodingList[index])
        }
        recordedAudio.deleteRecording(urlsToDelete: urlsToDelete)
    }
    
}

struct RecordingRow: View {
    @ObservedObject var audioRecorder = AudioRecorder()
    
    var recURL: URL
    
    var body: some View {
        HStack {
            Text("\(recURL.lastPathComponent)")
            Spacer()
            if audioRecorder.isPlaying == false {
                Button(action: {
                    audioRecorder.playSound(audio: recURL)
                    audioRecorder.isPlaying = true
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button(action: {
                    audioRecorder.stopSound()
                    audioRecorder.isPlaying = false
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                    
                }
            }
        }
        
    }
}
class RecordedAudio {
    var recodingList = [URL]()
    // 録音したリスト表示
    func audioDatas() -> [URL]{
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for recodings in directoryContents {
            recodingList.append(recodings)
            // リスト並び替えで新しい録音が上に足される
            recodingList.sort(by: {$0.lastPathComponent > $1.lastPathComponent})
        }
        
        return recodingList
    }
    // iPhoneファイルから削除
    func deleteRecording(urlsToDelete: [URL]) {
        for url in urlsToDelete {
            print(url)
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("File could not be deleted!")
            }
        }
    }
    
}



struct AudioListView_Previews: PreviewProvider {
    static var previews: some View {
        AudioListView()
    }
}

