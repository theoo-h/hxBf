package;

import bf.Lexer;
import bf.Parser;
import sys.io.File;

class Main {
	static function main() {
		var content = File.getContent(Sys.getCwd() + 'assets/script.bf');

		var lexer = new Lexer(content);
		var tokens = lexer.run();

		var parser = new Parser(tokens);
		var output = parser.run();

		trace(output);
	}
}
