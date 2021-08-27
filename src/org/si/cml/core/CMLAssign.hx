//----------------------------------------------------------------------------------------------------
// CML statement for assign class
//  Copyright (c) 2007 keim All rights reserved.
//  Distributed under BSD-style license (see license.txt).
//----------------------------------------------------------------------------------------------------
// Ported to haxe by Brian Gunn (gunnbr@gmail.com) in 2014


package org.si.cml.core;

import org.si.cml.core.Error;
import org.si.cml.CMLObject;
import org.si.cml.CMLFiber;

/** @private */
class CMLAssign extends CMLState
{
    // variables
    //------------------------------------------------------------
        private  var _index:Int = 0;
        public var max_reference:Int = 0;

        static public var assign_rex:String = "l\\$([1-9r]\\s*[+\\-*/=])=?";


    // functions
    //------------------------------------------------------------
        public function new(str:String)
        {
            super(CMLState.ST_NORMAL);

            var indexStr:String = str.charAt(0);
            if (indexStr == 'r') {
                _index = -1;
            } else {
                _index = Std.parseInt(indexStr)-1;
                max_reference = _index+1;
            }

            var index:Int = 1;
            while (StringTools.isSpace(str,index)) index++;

            var ope:String = (str.charAt(index));
            switch(ope) {
            case '+':   func = (_index == -1) ? _addr:_add;
            case '-':   func = (_index == -1) ? _subr:_sub;
            case '*':   func = (_index == -1) ? _mulr:_mul;
            case '/':   func = (_index == -1) ? _divr:_div;
            case '=':   func = (_index == -1) ? _asgr:_asg;
            default:    throw new Error('BUG!! Unknown operator "$ope" in assign');
            }
        }


        public override function _setCommand(cmd:String) : CMLState
        {
            return this;
        }


        private function _asgrg(fbr:CMLFiber):Bool { CMLObject._globalRank[_index]  = _args[0]; return true; }
        private function _addrg(fbr:CMLFiber):Bool { CMLObject._globalRank[_index] += _args[0]; return true; }
        private function _subrg(fbr:CMLFiber):Bool { CMLObject._globalRank[_index] -= _args[0]; return true; }
        private function _mulrg(fbr:CMLFiber):Bool { CMLObject._globalRank[_index] *= _args[0]; return true; }
        private function _divrg(fbr:CMLFiber):Bool { CMLObject._globalRank[_index] /= _args[0]; return true; }

        private function _asgr(fbr:CMLFiber):Bool { fbr.object.rank  = _args[0]; return true; }
        private function _addr(fbr:CMLFiber):Bool { fbr.object.rank += _args[0]; return true; }
        private function _subr(fbr:CMLFiber):Bool { fbr.object.rank -= _args[0]; return true; }
        private function _mulr(fbr:CMLFiber):Bool { fbr.object.rank *= _args[0]; return true; }
        private function _divr(fbr:CMLFiber):Bool { fbr.object.rank /= _args[0]; return true; }

        private function _asg(fbr:CMLFiber):Bool { fbr.vars[_index]  = _args[0]; return true; }
        private function _add(fbr:CMLFiber):Bool { fbr.vars[_index] += _args[0]; return true; }
        private function _sub(fbr:CMLFiber):Bool { fbr.vars[_index] -= _args[0]; return true; }
        private function _mul(fbr:CMLFiber):Bool { fbr.vars[_index] *= _args[0]; return true; }
        private function _div(fbr:CMLFiber):Bool { fbr.vars[_index] /= _args[0]; return true; }
}


