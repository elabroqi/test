//
//  ClientToServer.swift
//  Test_App
//
//  Created by Temp User on 1/4/26.
//


import Foundation
import Darwin
import SwiftUI

//create a client to server connection
final class ClientToServer {

    private var fd: Int32 = -1
    private let ip = "127.0.0.1"

    func connect() {
        
        //opening up the socket (addr_fam,socket_type, protocol - 0 - default)
        // That’s why protocols exist on top of TCP. (TCP - sends everything, doesn't preserve boundaries)
        fd = socket(AF_INET, SOCK_STREAM, 0)
        //public func socket(_: Int32, _: Int32, _: Int32) -> Int32
        
        //if the fd is not valid print error
        if fd < 0 {
            perror("socket")
            return
        }
        
        //else print the assigned fd for confirmation
        print("Socket opened with fd =", fd)
        
        //build a server address
        var serverAddr = sockaddr_in() //allocating memory, sets everything to zero. Addr type, port, IP
        
        //addr type
        serverAddr.sin_family = sa_family_t(AF_INET) //IPv4
        
        //port
        serverAddr.sin_port = UInt16(9000).bigEndian //HTTP port 80 , 9000 for docker , 443 HTTPS (public use)
        
        
        
        let ipResult = ip.withCString { cstr in
            inet_pton(AF_INET, cstr, &serverAddr.sin_addr)
        }

        if ipResult != 1 {
            print("Invalid IP address")
            close(fd)
            return
        }

        
        //create new variable and set it equal to the built server address
        var addr = serverAddr
        
        //crete an input called pointer and store memory address of serverAddr (&addr)
        let result = withUnsafePointer(to: &addr) { pointer in
            pointer.withMemoryRebound(to: sockaddr.self, capacity: 1) { sockaddrPtr in
                Darwin.connect(
                    fd,
                    sockaddrPtr,
                    socklen_t(MemoryLayout<sockaddr_in>.size)
                )
            }
        }
        
        // returns 0 -> success
        // returns -1 -> error
        
        if result != 0 {
            perror("connect")
            close(fd)
            return
        }

        print("CONNECTED TO SERVER")
        
    }
    
    func closeSocket(){
        if fd >= 0 {
            close(fd)
            fd = -1
            print("Socket closed")
        }
    }
}