import { randomBytes } from "@noble/ciphers/crypto";
import type { BytesCoder } from "@scure/base";
import { utils as baseUtils } from "@scure/base";

export type Bytes = Uint8Array; // a byte array
export type ByteLength = number; // the length of a Bytes array

// base32 strings (nopad)
export const base32nopad: BytesCoder = /* @__PURE__ */ baseUtils.chain(
	baseUtils.radix2(5),
	baseUtils.alphabet("abcdefghijklmnopqrstuvwxyz234567"),
	baseUtils.join(""),
);

// generate random bytes
export function random(length: ByteLength): Bytes {
	return randomBytes(length);
}

// base32 strings
export function toBase32(bytes: Bytes): string {
	return base32nopad.encode(bytes);
}
export function fromBase32(str: string): Bytes {
	return base32nopad.decode(str.toLowerCase());
}
export function alphabetBase32() {
	return "abcdefghijklmnopqrstuvwxyz234567";
}

process.stdout.write(toBase32(random(32)));
