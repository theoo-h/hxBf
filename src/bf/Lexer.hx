package bf;

import bf.Token;

/**
 * The Brainfuck lexer.
 * 
 * Converts a raw Brainfuck script into a list of tokens.
 * Keeps track of line and column positions for each token.
 * 
 * Used before the `Parser` to simplify syntax processing.
 */
class Lexer {
	/**
	 * The raw script content.
	 */
	private var content:String;

	/**
	 * Current reading position in the string.
	 */
	private var position:UInt;

	/**
	 * Current column index.
	 */
	private var column:UInt;

	/**
	 * Current line index.
	 */
	private var line:UInt;

	/**
	 * Creates a new Lexer instance.
	 * @param content The Brainfuck script to tokenize.
	 */
	public function new(content:String) {
		this.content = content;
	}

	/**
	 * Reads the full source and returns an array of tokens.
	 * Ignores any characters that are not valid Brainfuck commands.
	 */
	public function run():Array<Token> {
		position = 0;
		column = 1;
		line = 0;

		final tokens = [];

		while (position < content.length) {
			final charCode:Int = currentChar();
			final token:Token = resolveToken(charCode);

			if (token != null)
				tokens.push(token);

			consume();
		}

		return tokens;
	}

	/**
	 * Converts a character code into a Brainfuck token.
	 * Returns null if the character isn't part of the language.
	 */
	private function resolveToken(code:Int):Null<Token> {
		switch (code) {
			case "+".code:
				return TAdd(column, line);

			case "-".code:
				return TSub(column, line);

			case "<".code:
				return TDecrement(column, line);

			case ">".code:
				return TIncrement(column, line);

			case "[".code:
				return TLBracket(column, line);

			case "]".code:
				return TRBracket(column, line);

			case ".".code:
				return TDot(column, line);

			case ",".code:
				return TComma(column, line);

			default:
				return null;
		}
	}

	/**
	 * Returns the char code at the current reading position.
	 */
	private function currentChar():Int {
		return StringTools.unsafeCodeAt(content, position);
	}

	/**
	 * Advances the lexer to the next character.
	 * Also updates column and line counters.
	 */
	private function consume():Void {
		var currentChar:Int = currentChar();

		if (currentChar == '\n'.code) {
			line++;
			column = 1;
		} else
			column++;
		position++;
	}
}
