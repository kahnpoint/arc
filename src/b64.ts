import { Bytes } from '@/types'
import { randomBytes } from '@noble/ciphers/crypto'
import {
	concatBytes,
	equalBytes
} from '@noble/ciphers/utils'
import { base64 } from '@scure/base'

// generate random bytes
function random(length: number): Bytes {
	return randomBytes(length)
}

process.stdout.write(base64.encode(random(32)));