package com.example.devops;

import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.nio.charset.StandardCharsets;

public class SimpleCalculate {

    public double add(double a, double b) { return a + b; }
    public double subtract(double a, double b) { return a - b; }
    public double multiply(double a, double b) { return a * b; }
    public double divide(double a, double b) { return a / b; }

    public static void main(String[] args) throws IOException {
        
        int port = 9090;
        HttpServer server = HttpServer.create(new InetSocketAddress(port), 0);
        server.createContext("/", new CalculatorPageHandler());
        server.setExecutor(null);

        System.out.println("Server running on http://localhost:" + port);
        server.start();
    }

    static class CalculatorPageHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {
            String html = """
                    <!DOCTYPE html>
                    <html>
                    <head>
                      <title>Simple Calculator</title>
                      <style>
                        body { font-family: Arial; padding: 40px; }
                        input { margin: 5px; padding: 8px; width: 120px; }
                        button { padding: 8px 15px; margin: 5px; }
                        #result { margin-top: 15px; font-size: 20px; color: green; }
                      </style>
                    </head>
                    <body>
                      <h1>Simple Calculator</h1>
                      <input id="a" type="number" step="any" placeholder="First number">
                      <input id="b" type="number" step="any" placeholder="Second number"><br><br>
                      <button onclick="calc('+')">+</button>
                      <button onclick="calc('-')">-</button>
                      <button onclick="calc('*')">*</button>
                      <button onclick="calc('/')">/</button>
                      <div id="result"></div>

                      <script>
                        function calc(op) {
                          const a = parseFloat(document.getElementById('a').value);
                          const b = parseFloat(document.getElementById('b').value);
                          let r;
                          if (op === '+') r = a + b;
                          else if (op === '-') r = a - b;
                          else if (op === '*') r = a * b;
                          else if (op === '/') {
                            if (b === 0) {
                              document.getElementById('result').innerHTML = 'Cannot divide by zero.';
                              return;
                            }
                            r = a / b;
                          }
                          document.getElementById('result').innerHTML =
                            a + ' ' + op + ' ' + b + ' = <b>' + r + '</b>';
                        }
                      </script>
                    </body>
                    </html>
                    """;

            byte[] response = html.getBytes(StandardCharsets.UTF_8);
            exchange.getResponseHeaders().set("Content-Type", "text/html; charset=UTF-8");
            exchange.sendResponseHeaders(200, response.length);
            try (OutputStream os = exchange.getResponseBody()) {
                os.write(response);
            }
        }
    }
}

//make some changes
