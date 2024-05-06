package minimal_example

import "core:fmt"
import "core:log"
import "core:net"

import http "../.."

// Minimal server that listens on 127.0.0.1:8080 and responds to every request with 200 Ok.
main :: proc() {
	s: http.Server

	handler := http.handler(proc(_: ^http.Request, res: ^http.Response) {
		res.status = .OK
		http.respond_plain(res, "Hello, world!\n")
	})

	http.server_shutdown_on_interrupt(&s)

	err := http.listen_and_serve(&s, handler, net.Endpoint{address = net.IP4_Loopback, port = 3000})
	fmt.assertf(err == nil, "server stopped with error: %v", err)
}
