import {conHello, fnPlusNumbers} from './library_named.js';
console.log(conHello, 'export naemd');
console.log('1+2 = ', fnPlusNumbers(1,2));

import * as myLibrary from './library_named.js';
console.log(myLibrary.conHello, 'export named using *');
console.log('3+4 = ', myLibrary.fnPlusNumbers(3,4));

import fnMyfunction from './library_default.js';
console.log('export default');
console.log('5+6 = ', fnMyfunction(5,6));