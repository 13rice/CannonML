package org.si.cml.core;

#if js
import js.Error as BaseError;
#elseif hl
import Sys.SysError as BaseError;
#end

class Error
{
	public function new(e: String )
	{
		#if (js || hl )
			new BaseError(e);
		#else
			throw e;
		#end
	}
}