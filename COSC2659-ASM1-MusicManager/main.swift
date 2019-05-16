//
//  main.swift
//  COSC2659-ASM1-MusicManager
//
//  Created by Toan Do on 3/9/19.
//  Copyright © 2019 Toan Do. All rights reserved.
//
/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2019A
 Assessment: Assignment 1
 Author: Do Quoc Toan
 ID: s3652979
 Created date: 9/3/2019
 */

import Foundation
import AVFoundation
import SpriteKit

enum Genre: String{
    case Blues = "Blues"
    case Classical = "Classical"
    case Country = "Country"
    case Electronic = "Electronic"
    case Folk = "Folk"
    case Jazz = "Jazz"
    case Latin = "Latin"
    case Pop = "Pop"
    case NewAge = "NewAge"
    case Reggae = "Reggae"
    case Rock = "Rock"
    case RB = "R&B"
}

//get the filename and cut extension .mp3
func subString (string: String) -> String{
    var newString : String = ""
    for s in string{
        if s != "."{
            newString.append(s)
        }else{
            break
        }
    }
    return newString
}

public class Playlist{
    var pName: String
    var songArray : Array<Song>
    init(pName: String, songArray : Array<Song> = []) {
        self.pName = pName
        self.songArray = songArray
    }
    func getpName() -> String {return self.pName}
    func getsongArray() -> Array<Song> {return self.songArray}
    func setpName(pName: String){self.pName = pName}
    func setsongArray(array: Array<Song>){self.songArray = array}


    func toString(){
    }
}


public class Song {
    var title: String
    var yearOfRecording: Double
    var artistNames: String
    var genre: Genre
    var duration: Double
    var filename: String
    init( title: String, artistNames: String = "", yearOfRecording: Double = 0, genre: Genre = .RB, duration: Double = 0, filename: String) {
        self.title = title
        self.artistNames = artistNames
        self.yearOfRecording = yearOfRecording
        self.genre = genre
        self.duration = duration
        self.filename = filename
    }
    func getTitle() -> String {return self.title}
    func getYear() -> Double {return self.yearOfRecording}
    func getArttists() -> String {return self.artistNames}
    func getGenre() -> Genre {return self.genre}
    func getDuration() -> Double {return self.duration}
    func getFilename() -> String {return self.filename}
    
    func setTitle(title: String){self.title = title}
    func setYear(year: Double){self.yearOfRecording = year}
    func setArtists(artists: String){self.artistNames = artists}
    func setGenre(genre: String){self.genre = Genre(rawValue: genre)!}
    func setDuration(duration: Double){self.duration = duration}
    func toString(){
        print(self.title)
    }
}
func getMusicDirectory() -> String {
    return stringStriping(inputString: #file, deleteString: "main.swift") + "Music/"
}
//modify the directory function
func stringStriping(inputString:String, deleteString:String) -> String {
    var string = inputString
    if let range = string.range(of: deleteString) {
        string.removeSubrange(range)
    }
    return string
}

//listing a list of songs at Folder Music
func readFolder() -> Array<Song>{
    //readFolder
    var array : Array<Song> = Array()
    do {
        let items = try FileManager.default.contentsOfDirectory(atPath: getMusicDirectory())
        for item in items {
            let song = Song (title: subString(string: item), filename: item)
            array.append(song)
        }
    } catch {
        //throw error
        print("Cannot read this directory")
    }
    //print list of Songs in the array
    return array
}


func choice1(array: Array<Song>){
    for i in 0...(array.count-1){
        print("\(i+1).Title:\(array[i].getTitle())-Year:\(array[i].getYear())-Artists:\(array[i].getArttists())-Genre:\(array[i].getGenre())-Duration:\(array[i].getDuration())")
    }
    print("Choose song:")
    let number = Int(readLine()!)!
    
    var audioPlayer:AVAudioPlayer!
    let audioFilePath = getMusicDirectory() + array[number-1].getTitle()+".mp3"
    
    if audioFilePath != "" {
        let audioFileUrl = NSURL.fileURL(withPath: getMusicDirectory() + "demo.mp3")
        do{
            audioPlayer =  try AVAudioPlayer(contentsOf: audioFileUrl)
        } catch{
            print(error)
        }
        audioPlayer.play()
        print("Playing song")
    } else {
        print("audio file is not found")
    }
    
    while audioPlayer.isPlaying {
        let status = readLine()
        if status == "stop"{
            audioPlayer.stop()
        }else{
            print("Enjoy...")
        }
    }
}
func choice2(array: Array<Song>) -> Array<Song>{
    while  true {
        for i in 0...(array.count-1){
            print("\(i+1).Title:\(array[i].getTitle())-Year:\(array[i].getYear())-Artists:\(array[i].getArttists())-Genre:\(array[i].getGenre())-Duration:\(array[i].getDuration())")
        }
        let j = array.count
        print("Enter the song that you want to edit or 0 to exit")
        let choice : Int = Int(readLine()!)!
        if choice == 0{
            return array
        }else if 1...j ~= choice{
            print("Enter new title:")
            array[choice-1].setTitle(title: readLine()!)
            print("Enter new yearOfRecording:")
            array[choice-1].setYear(year: Double(readLine()!)!)
            print("Enter new Artist:")
            array[choice-1].setArtists(artists: readLine()!)
            print("Enter new genre")
            array[choice-1].setGenre(genre: readLine()!)
            print("Enter new duration:")
            array[choice-1].setDuration(duration: Double(readLine()!)!)
        }else{
            print("Invalid Input!\nPlease input again!")
        }
    }
}
func choice3(array: Array<Song>){
    print("List of all song:")
    for i in 0...(array.count-1){
        print("\(i+1).Title:\(array[i].getTitle())-Year:\(array[i].getYear())-Artists:\(array[i].getArttists())-Genre:\(array[i].getGenre())-Duration:\(array[i].getDuration())")
    }
}
func choice4(array: Array<Song>) -> Array<Song>{
    var tempArray = array
    while true {
        for i in 0...(tempArray.count-1){
            print("\(i+1).Title:\(tempArray[i].getTitle())-Year:\(tempArray[i].getYear())-Artists:\(tempArray[i].getArttists())-Genre:\(tempArray[i].getGenre())-Duration:\(tempArray[i].getDuration())")
        }
        let j = tempArray.count
        print("Enter song that you want to delete or 0 to exit")
        let choice : Int = Int(readLine()!)!
        if choice == 0 {
            return tempArray
        }else if choice > 0 && choice <= j {
            tempArray.remove(at: choice-1)
        }else{
            print("Invalid Input")
        }
    }
}
func choice5(array: Array<Song>, playlistArray: Array<Playlist>) -> Array<Playlist>{
    var tempArray = array
    var tempPlaylistArray = playlistArray
    print("Enter name of Playlist to create:")
    var temp = Array<Song>()
    let name = readLine()
    let pList = Playlist(pName: name!)
    while true{
        if tempArray.count >= 1 {
            for i in 0...(tempArray.count-1){
                print("\(i+1).Title:\(tempArray[i].getTitle())-Year:\(tempArray[i].getYear())-Artists:\(tempArray[i].getArttists())-Genre:\(tempArray[i].getGenre())-Duration:\(tempArray[i].getDuration())")
            }
        }else{
            break
        }
        print("Choose song to add, 0 to exit")
        let song = Int(readLine()!)!
        if song == 0 {
            break
        }else if song > tempArray.count{
            print("Invalid Input")
        }
        temp.append(tempArray[song-1])
        tempArray.remove(at: song - 1)
    }
    pList.setsongArray(array: temp)
    tempPlaylistArray.append(pList)
    return tempPlaylistArray
}
func choice6(array: Array<Playlist>){
    for i in 0...(array.count-1){
        print("\(i+1).PlaylistName:\(array[i].getpName())")
    }
}
func choice7(array: Array<Playlist>)-> Array<Playlist>{
    var tempArray = array
    if tempArray.count >= 1 {
        for i in 0...(tempArray.count-1){
            print("\(i+1).PlaylistName:\(tempArray[i].getpName())")
        }
        print("Which playlist do you want to edit?")
        let a = Int(readLine()!)!
        print("Enter name of playlist:")
        let b = readLine()!
        tempArray[a-1].setpName(pName: b)
        return tempArray
    }else{
        return tempArray
    }
}
func choice8(array: Array<Playlist>)-> Array<Playlist>{
    var tempArray = array
    if tempArray.count >= 1 {
        for i in 0...(tempArray.count-1){
            print("\(i+1).PlaylistName:\(tempArray[i].getpName())")
        }
        print("Which playlist do you want to delete?")
        let a = Int(readLine()!)!
        tempArray.remove(at: a-1)
        return tempArray
    }else{
        return tempArray
    }
}
func choice9(array: Array<Playlist>)-> Array<Playlist>{
    var tempArray = array
    if tempArray.count >= 1 {
        for i in 0...(tempArray.count-1){
            print("\(i+1).PlaylistName:\(tempArray[i].getpName())")
        }
        print("Which playlist do you want to access?")
        let a = Int(readLine()!)!
        var list = tempArray[a-1].getsongArray()
        while(true){
            if list.count >= 1 {
                for i in 0...(list.count-1){
                    print("\(i+1).Title:\(list[i].getTitle())-Year:\(list[i].getYear())-Artists:\(list[i].getArttists())-Genre:\(list[i].getGenre())-Duration:\(list[i].getDuration())")
                }
                print("select song to remove or 0 to exit")
                let song = Int(readLine()!)!
                if song == 0{
                    break
                }else{
                    list.remove(at: song-1)
                }
            }else{
                break
            }
        }
        tempArray[a-1].setsongArray(array: list)
        return tempArray
    }else{
        return tempArray
    }
}
func choice10(array: Array<Playlist>){
    var tempArray = array
    if tempArray.count >= 1 {
        for i in 0...(tempArray.count-1){
            print("PlaylistName:\(tempArray[i].getpName())")
            var tempList = tempArray[i].getsongArray()
            if tempList.count >= 1{
                for i in 0...(tempList.count-1){
                    print("\(i+1).Title:\(tempList[i].getTitle())-Year:\(tempList[i].getYear())-Artists:\(tempList[i].getArttists())-Genre:\(tempList[i].getGenre())-Duration:\(tempList[i].getDuration())")
                }
            }
        }
    }
}

func choice11(array: Array<Playlist>){
    for i in 0...(array.count-1){
        print("\(i+1).PlaylistName:\(array[i].getpName())")
    }
    print("Choose playlist to play:")
    let play = Int(readLine()!)!
    var tempArray = array[play - 1].getsongArray()
    for i in 0...(tempArray.count-1){
        print("\(i+1).Title:\(tempArray[i].getTitle())-Year:\(tempArray[i].getYear())-Artists:\(tempArray[i].getArttists())-Genre:\(tempArray[i].getGenre())-Duration:\(tempArray[i].getDuration())")
    }
    for y in 0...(tempArray.count-1){
        var audioPlayer:AVAudioPlayer!
        let audioFilePath = getMusicDirectory() + tempArray[y].getTitle()+".mp3"
        
        if audioFilePath != "" {
            let audioFileUrl = NSURL.fileURL(withPath: getMusicDirectory() + tempArray[y].getTitle()+".mp3")
            do{
                audioPlayer =  try AVAudioPlayer(contentsOf: audioFileUrl)
            } catch{
                print(error)
            }
            audioPlayer.play()
            print("Playing song")
        } else {
            print("audio file is not found")
        }
        
        while audioPlayer.isPlaying {
            let status = readLine()
            if status == "stop"{
                audioPlayer.stop()
            }else{
                print("Enjoy...")
            }
        }
    }
    
    
}

//main code
print("--------Welcome to Music Management Program--------")
var listOfPlaylists = Array<Playlist>()
var listOfSongs = readFolder()
while true{
    print("---------------------Options----------------------\n1.Play a song\n2.Edit a song\n3.List of songs\n4.Delete a song\n5.Create Playlist\n6.List of Playlists\n7.Edit PlaylistName\n8.DeletePlaylist\n9.Remove songs of playlist\n10.Display Playlist Info\n11.Play a playlist\n0.Exit")
    print("Enter your choice:")
    let choice : Int = Int(readLine()!)!
    if choice == 1 {
        choice1(array: listOfSongs)
    }else if choice == 2{
        listOfSongs = choice2(array: listOfSongs)
    }else if choice == 3{
        choice3(array: listOfSongs)
    }else if choice == 4{
        listOfSongs = choice4(array: listOfSongs)
    }else if choice == 5{
        listOfPlaylists = choice5(array: listOfSongs, playlistArray: listOfPlaylists )
    }else if choice == 6{
        choice6(array: listOfPlaylists)
    }else if choice == 7{
        listOfPlaylists = choice7(array: listOfPlaylists)
    }else if choice == 8{
        listOfPlaylists = choice8(array: listOfPlaylists)
    }else if choice == 9{
        listOfPlaylists = choice9(array: listOfPlaylists)
    }else if choice == 10{
        choice10(array: listOfPlaylists)
    }else if choice == 11{
        choice11(array: listOfPlaylists)
    }
}

