const fs = require('fs')
const readline = require('readline')
const { once } = require('events')
const INPUT_FILE = process.env.INPUT_FILE
const USE_STREAM = process.env.USE_STREAM === 'true'
const REPORT_MEM = process.env.REPORT_MEM === 'true'
const DO_NOT_EXIT = process.env.DO_NOT_EXIT === 'true'

const readFileByLine = async path => {
  const rl = readline.createInterface({
    input: fs.createReadStream(path),
    crlfDelay: Infinity
  })
  rl.on('line', console.log)
  // for await (const line of rl) {
  //   console.log(line)
  // }
  await once(rl, 'close')
}

const printFile = async (path, useStream) => {
  if (useStream) {
    return readFileByLine(path)
  }
  console.log((await fs.promises.readFile(path)).toString())
}

const main = async () => {
  if (!INPUT_FILE) {
    throw new Error('Set INPUT_FILE to specify file to read.')
  }

  if (REPORT_MEM) {
    setInterval(() => {
      console.log(`Memory Usage: ${(process.memoryUsage().rss / 1024 ** 2).toFixed(2)} MiB`)
    }, 500).unref()
  }

  try {
    const result = await fs.promises.stat(INPUT_FILE)
    console.log(`Input: ${INPUT_FILE}, size: ${result.size / 1024 ** 2} MiB`)
    await printFile(INPUT_FILE, USE_STREAM)

    if (DO_NOT_EXIT) {
      console.log('sleeping...')
      setInterval(() => {}, 1000 * 60 * 60 * 24)
    }
  } catch (error) {
    console.error(error)
  }
}

main()
