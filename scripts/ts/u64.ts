// print a random u64, padded with zeros to 20 characters
const high = BigInt(Math.floor(Math.random() * 0x100000000));
const low = BigInt(Math.floor(Math.random() * 0x100000000));
const u64 = (high << 32n) | low;
console.log(u64.toString().padStart(20, "0"));
