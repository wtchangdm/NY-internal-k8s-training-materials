const { hostname } = require('os')
const server = require('fastify').fastify({ logger: true })
const PORT = Number(process.env.PORT) || 3000

const config = {
  HOSTNAME: hostname(),
  COLOR: process.env?.COLOR?.toLowerCase() || 'blue',
  VERSION: process.env.VERSION ?? 'N/A',
  SECRET_PASSWORD: process.env.SECRET_PASSWORD ?? 'N/A',
  REFRESH_INTERVAL: Number(process.env.REFRESH_INTERVAL) || 500,
  WEB_MODE: process.env.WEB_MODE === 'true',
  get TIMESTAMP () { return Date.now() }
}

const reload = `<script>setTimeout(() => location.reload(), ${config.REFRESH_INTERVAL})</script>`

const getPage = () => `<!DOCTYPE html><html><head></<head><body style="color: ${config.COLOR}">${Object.entries(config).map(([k, v]) => `${k}: ${v}`).join('<br>')}${reload}</body></html>`

const start = async () => {
  server.get('/health', async (req, res) => {
    return { health: 'ok' }
  })
  server.get('*', async (req, res) => {
    if (config.WEB_MODE) {
      return res.type('text/html').send(getPage())
    }
    return Object.entries(config).map(([k, v]) => `${k}: ${v}`).join(', ') + '\n'
  })
  await server.listen({ host: '0.0.0.0', port: PORT })
}

start()
