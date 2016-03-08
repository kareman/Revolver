/*
Not original code! (thankfully - who would bother reimplementing this?)
- attribution goes to: http://stackoverflow.com/questions/2469031/open-source-implementation-of-mersenne-twister-in-python
- transitive attribution goes to: http://code.activestate.com/lists/python-list/%3c200210290825.05022.shalehperry@attbi.com%3e/

A C -> python -> swift translation of MT19937, original license below.

--
A C-program for MT19937: Real number version
genrand() generates one pseudorandom real number (double)
which is uniformly distributed on [0,1]-interval, for each
call. sgenrand(seed) set initial values to the working area
of 624 words. Before genrand(), sgenrand(seed) must be
called once. (seed is any 32-bit integer except for 0).
Integer generator is obtained by modifying two lines.
Coded by Takuji Nishimura, considering the suggestions by
Topher Cooper and Marc Rieffel in July-Aug. 1997.

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Library General Public
License as published by the Free Software Foundation; either
version 2 of the License, or (at your option) any later
version.
This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Library General Public License for more details.
You should have received a copy of the GNU Library General
Public License along with this library; if not, write to the
Free Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307  USA

Copyright (C) 1997 Makoto Matsumoto and Takuji Nishimura.
Any feedback is very welcome. For any question, comments,
see http://www.math.keio.ac.jp/matumoto/emt.html or email
matumoto@math.keio.ac.jp
--
*/

/// Implementation of Mersenne Twister ported from Python.
public class MersenneTwister: EntropyGenerator {
    // MARK: - Period parameters
    private let N = 624
    private let M = 397
    private let MATRIX_A = 0x9908b0df   // constant vector a
    private let UPPER_MASK = 0x80000000 // most significant w-r bits
    private let LOWER_MASK = 0x7fffffff // least significant r bits
    
    // MARK: - Tempering parameters
    private let TEMPERING_MASK_B = 0x9d2c5680
    private let TEMPERING_MASK_C = 0xefc60000
    
    private func TEMPERING_SHIFT_U(y: Int) -> Int {
        return y >> 11
    }
    
    private func TEMPERING_SHIFT_S(y: Int) -> Int {
        return y << 7
    }
    
    private func TEMPERING_SHIFT_T(y: Int) -> Int {
        return y << 15
    }
    
    private func TEMPERING_SHIFT_L(y: Int) -> Int {
        return y >> 18
    }
    
    private var mt: [Int]
    private var mti: Int
    
    // MARK: - Initialization
    public init(seed: Int) {
        mt = []
        mti = N
        sgenrand(seed)
    }
    
    private func sgenrand(seed: Int) {
        mt = []
        
        mt.append(seed & 0xffffffff)
        for i in 1...N {
            mt.append((69069 * mt[i-1]) & 0xffffffff)
        }
        
        mti = N+1
    }
    
    public func next() -> Double {
        var mag01 = [0x0, MATRIX_A]
        // mag01[x] = x * MATRIX_A  for x=0,1
        var y = 0
        
        if mti >= N { // generate N words at one time
            if mti == N+1 {   // if sgenrand() has not been called,
                sgenrand(4357) // a default initial seed is used
            }
            
            for kk in 0...(N-M) {
                y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK)
                mt[kk] = mt[kk+M] ^ (y >> 1) ^ mag01[y & 0x1]
            }
            
            for kk in ((N-M) + 1)..<N {
                y = (mt[kk]&UPPER_MASK)|(mt[kk+1]&LOWER_MASK)
                mt[kk] = mt[kk+(M-N)] ^ (y >> 1) ^ mag01[y & 0x1]
            }
            
            y = (mt[N-1]&UPPER_MASK)|(mt[0]&LOWER_MASK)
            mt[N-1] = mt[M-1] ^ (y >> 1) ^ mag01[y & 0x1]
            
            mti = 0
        }
        
        y = mt[mti]
        mti += 1
        y ^= TEMPERING_SHIFT_U(y)
        y ^= TEMPERING_SHIFT_S(y) & TEMPERING_MASK_B
        y ^= TEMPERING_SHIFT_T(y) & TEMPERING_MASK_C
        y ^= TEMPERING_SHIFT_L(y)
        
        return Double(y) / 0xffffffff // reals
    }
}
