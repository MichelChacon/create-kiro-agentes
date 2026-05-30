#!/usr/bin/env node

/**
 * Servidor MCP local para Exa
 * Usa la API REST de Exa directamente
 */

const https = require('https');

const EXA_API_KEY = process.env.EXA_API_KEY;

if (!EXA_API_KEY) {
  console.error('Error: EXA_API_KEY no está configurado');
  process.exit(1);
}

// Función para hacer búsquedas en Exa
function searchExa(query, numResults = 10) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      query: query,
      num_results: numResults,
      type: "auto",
      contents: {
        highlights: true
      }
    });

    const options = {
      hostname: 'api.exa.ai',
      port: 443,
      path: '/search',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': EXA_API_KEY,
        'Content-Length': data.length
      }
    };

    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => body += chunk);
      res.on('end', () => {
        if (res.statusCode === 200) {
          resolve(JSON.parse(body));
        } else {
          reject(new Error(`Exa API error: ${res.statusCode} - ${body}`));
        }
      });
    });

    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

// Función para obtener contenido de URLs
function getContents(urls) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify({
      urls: urls,
      highlights: true
    });

    const options = {
      hostname: 'api.exa.ai',
      port: 443,
      path: '/contents',
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': EXA_API_KEY,
        'Content-Length': data.length
      }
    };

    const req = https.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => body += chunk);
      res.on('end', () => {
        if (res.statusCode === 200) {
          resolve(JSON.parse(body));
        } else {
          reject(new Error(`Exa API error: ${res.statusCode} - ${body}`));
        }
      });
    });

    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

// Servidor MCP usando stdio
process.stdin.setEncoding('utf8');

let buffer = '';

process.stdin.on('data', async (chunk) => {
  buffer += chunk;
  
  // Procesar mensajes completos (separados por newline)
  const lines = buffer.split('\n');
  buffer = lines.pop(); // Guardar línea incompleta
  
  for (const line of lines) {
    if (!line.trim()) continue;
    
    try {
      const request = JSON.parse(line);
      
      if (request.method === 'tools/list') {
        // Listar herramientas disponibles
        const response = {
          jsonrpc: '2.0',
          id: request.id,
          result: {
            tools: [
              {
                name: 'web_search_exa',
                description: 'Search the web using Exa neural search',
                inputSchema: {
                  type: 'object',
                  properties: {
                    query: {
                      type: 'string',
                      description: 'Search query'
                    },
                    num_results: {
                      type: 'number',
                      description: 'Number of results to return (default: 10)'
                    }
                  },
                  required: ['query']
                }
              },
              {
                name: 'web_fetch_exa',
                description: 'Get content from specific URLs using Exa',
                inputSchema: {
                  type: 'object',
                  properties: {
                    urls: {
                      type: 'array',
                      items: { type: 'string' },
                      description: 'URLs to fetch content from'
                    }
                  },
                  required: ['urls']
                }
              }
            ]
          }
        };
        process.stdout.write(JSON.stringify(response) + '\n');
        
      } else if (request.method === 'tools/call') {
        // Ejecutar herramienta
        const { name, arguments: args } = request.params;
        
        let result;
        if (name === 'web_search_exa') {
          result = await searchExa(args.query, args.num_results || 10);
        } else if (name === 'web_fetch_exa') {
          result = await getContents(args.urls);
        } else {
          throw new Error(`Unknown tool: ${name}`);
        }
        
        const response = {
          jsonrpc: '2.0',
          id: request.id,
          result: {
            content: [
              {
                type: 'text',
                text: JSON.stringify(result, null, 2)
              }
            ]
          }
        };
        process.stdout.write(JSON.stringify(response) + '\n');
        
      } else if (request.method === 'initialize') {
        // Inicialización
        const response = {
          jsonrpc: '2.0',
          id: request.id,
          result: {
            protocolVersion: '2024-11-05',
            capabilities: {
              tools: {}
            },
            serverInfo: {
              name: 'exa-mcp-server',
              version: '1.0.0'
            }
          }
        };
        process.stdout.write(JSON.stringify(response) + '\n');
      }
      
    } catch (error) {
      const errorResponse = {
        jsonrpc: '2.0',
        id: request?.id || null,
        error: {
          code: -32603,
          message: error.message
        }
      };
      process.stdout.write(JSON.stringify(errorResponse) + '\n');
    }
  }
});

process.stdin.on('end', () => {
  process.exit(0);
});

console.error('Exa MCP Server iniciado');
