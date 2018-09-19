package main

import (
	"flag"
	"io"
	"log"
	"net"
	"os"

	"github.com/facebookgo/flagenv"
)

var (
	addr = flag.String("addr", "127.0.0.1:31337", "socket to listen on")
)

func main() {
	flagenv.Parse()
	flag.Parse()

	os.RemoveAll(*addr)
	l, err := net.Listen("tcp", *addr)
	if err != nil {
		log.Fatal(err)
	}

	log.Printf("listening on %s", *addr)
	for {
		c, err := l.Accept()
		if err != nil {
			log.Fatal(err)
		}

		log.Printf("got connection from %s", c.RemoteAddr())
		go handleClient(c)
	}
}

func handleClient(c net.Conn) {
	defer c.Close()

	for {
		io.Copy(os.Stdout, c)
	}

	log.Printf("connection closed from %s", c.RemoteAddr())
}
