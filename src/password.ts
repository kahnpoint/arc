var randomize = require('randomatic');

/*
To generate a 10-character randomized string using all available characters:

randomize('*', 10);
//=> 'x2_^-5_T[$'
 
randomize('Aa0!', 10);
//=> 'LV3u~BSGhw'
a: Lowercase alpha characters (abcdefghijklmnopqrstuvwxyz')
A: Uppercase alpha characters (ABCDEFGHIJKLMNOPQRSTUVWXYZ')
0: Numeric characters (0123456789')
!: Special characters (~!@#$%^&()_+-={}[];\',.)
*: All characters (all of the above combined)
?: Custom characters (pass a string of custom characters to the options)
*/

let password = '';
const SEGMENT_LENGTH = 6;
const SEGMENTS = 4;
for (let segment = 0; segment < SEGMENTS; segment++) {
	password += randomize('Aa0', SEGMENT_LENGTH) + '-';
}
password = password.slice(0, -1);

console.log(password);
