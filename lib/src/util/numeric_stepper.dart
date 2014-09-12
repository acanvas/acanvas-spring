part of spring_dart;
	/**
	 * @author Simon Schmid (contact(at)sschmid.com)
	 */
	 class NumericStepper {
		var _min ;
		var _max ;
		var _step ;
		var _loop ;
		var _curStep ;

		NumericStepper(min , max , [step  = 1, loop  = true]) {
			_min = min;
			_max = max;
			_step = step;
			_loop = loop;
			_curStep = min;
		}


		num get value  {
			return _curStep;
		}


		num get step  {
			return _step;
		}


		void set step(step ) {
			_step = step;
		}


		num jumpTo(i )  {
			return _update(i, false);
		}


		num jumpToFirst()  {
			_curStep = _min;
			return _curStep;
		}


		num jumpToLast()  {
			_curStep = _max;
			return _curStep;
		}


		num forward()  {
			return _update(_curStep + _step, _loop);
		}


		num back()  {
			return _update(_curStep - _step, _loop);
		}


		num _update(i , loop )  {
			if (i != _curStep) {
				if (i < _min) {
					if (loop) _curStep = _max;
					else _curStep = _min;
				} else if (i > _max) {
					if (loop) _curStep = _min;
					else _curStep = _max;
				} else {
					_curStep = i;
				}
			}
			return _curStep;
		}


		num get min {
			return _min;
		}


		void set min(min ) {
			_min = min;
		}


		num get max  {
			return _max;
		}


		void set max(max ) {
			_max = max;
		}


		bool get loop  {
			return _loop;
		}


		void set loop(loop ) {
			_loop = loop;
		}
	}
