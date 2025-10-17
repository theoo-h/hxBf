package bf.misc;

/**
 * i was bored
 * lazy enough to not make docs
 * 
 * ported from here:
 * https://codegolf.stackexchange.com/questions/5418/brainf-golfer/5440#5440
 */
class Converter {
	var text:String;

	public function new(text:String) {
		this.text = text;
	}

	public function run():String {
		var result:String;

		if (text.length <= 3) {
			result = "";
			for (c in text.split('')) {
				final code = StringTools.unsafeCodeAt(c, 0);
				result += ">";

				if (code < 12) {
					for (i in 0...code) {
						result += "+";
					}
					result += ".>";
				} else {
					final root:Int = Std.int(Math.sqrt(code));
					for (i in 0...root) {
						result += "+";
					}
					result += "[>";
					final quotient:Int = Std.int(code / root);
					for (i in 0...quotient) {
						result += "+";
					}
					result += "<-]>";
					final remainder:Int = code - (root * quotient);
					for (i in 0...remainder) {
						result += "+";
					}
					result += ".";
				}
			}
		} else {
			var offsets:Array<Array<Int>> = [[], [], []];
			result = "---";

			for (c in text.split('')) {
				final code:Int = c.charCodeAt(0);
				offsets[0].push(Std.int(code / 49));
				final temp:Int = code % 49;
				offsets[1].push(Std.int(temp / 7));
				offsets[2].push(temp % 7);
			}

			// offsets[0]
			for (o in offsets[0]) {
				switch (o) {
					case 0:
						result += ">--";
					case 1:
						result += ">-";
					case 2:
						result += ">";
					case 3:
						result += ">+";
					case 4:
						result += ">++";
					case 5:
						result += ">+++";
				}
			}
			result += ">+[-[>+++++++<-]<+++]>----";

			// offsets[1]
			for (o in offsets[1]) {
				switch (o) {
					case 0:
						result += ">---";
					case 1:
						result += ">--";
					case 2:
						result += ">-";
					case 3:
						result += ">";
					case 4:
						result += ">+";
					case 5:
						result += ">++";
					case 6:
						result += ">+++";
				}
			}
			result += ">+[-[>+++++++<-]<++++]>----";

			// offsets[2]
			for (o in offsets[2]) {
				switch (o) {
					case 0:
						result += ">---";
					case 1:
						result += ">--";
					case 2:
						result += ">-";
					case 3:
						result += ">";
					case 4:
						result += ">+";
					case 5:
						result += ">++";
					case 6:
						result += ">+++";
				}
			}
			result += ">+[-<++++]>[.>]";
		}

		return result;
	}
}
