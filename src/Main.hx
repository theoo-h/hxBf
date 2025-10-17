package;

import bf.Lexer;
import bf.Parser;
import bf.misc.Converter;
import sys.io.File;

class Main {
	static function main() {
		var converter = new Converter('Hello, world !');
		var content = converter.run();
		trace(content);
		// var content =  File.getContent(Sys.getCwd() + 'assets/script.bf');

		var lexer = new Lexer(content);
		var tokens = lexer.run();

		var parser = new Parser(tokens);
		var output = parser.run();

		trace(output);
	}
}
