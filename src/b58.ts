import { Bytes } from '@/types'
import { randomBytes } from '@noble/ciphers/crypto'
import {
	concatBytes,
	equalBytes
} from '@noble/ciphers/utils'
import { base58xmr } from '@scure/base'

// generate random bytes
function random(length: number): Bytes {
	return randomBytes(length)
}

process.stdout.write(base58xmr.encode(random(32)));