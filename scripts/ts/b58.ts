import { randomBytes } from "@noble/ciphers/crypto";
import { base58xmr } from "@scure/base";
import type { Bytes } from "@/types";

// generate random bytes
function random(length: number): Bytes {
	return randomBytes(length);
}

process.stdout.write(base58xmr.encode(random(32)));
