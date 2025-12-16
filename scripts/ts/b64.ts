import { randomBytes } from "@noble/ciphers/crypto";
import { base64 } from "@scure/base";
import type { Bytes } from "@/types";

// generate random bytes
function random(length: number): Bytes {
	return randomBytes(length);
}

process.stdout.write(base64.encode(random(32)));
