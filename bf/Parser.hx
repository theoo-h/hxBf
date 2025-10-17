package bf;

import bf.core.Error;
import bf.core.IOType;
import bf.core.InfoError;
import haxe.ds.IntMap;
import haxe.io.Bytes;

using haxe.io.Bytes;

/**
 * The Brainfuck parser and interpreter.
 * 
 * Takes the tokens produced by `Lexer` and executes them directly.
 * 
 * Handles memory, loops, and io behavior defined by Brainfuck.
 */
class Parser {
	/**
	 * List of tokens.
	 */
	var tokens:Array<Token>;

	/**
	 * Current token index.
	 */
	var position:UInt;

	/**
	 * Byte buffer.
	 * Reprecenting Brainfuck Memory Storage.
	 */
	var buffer:Bytes;

	/**
	 * Memory pointer.
	 */
	var ptr:UInt;

	/**
	 * I/O Type.
	 */
	var ioType:IOType;

	/**
	 * Creates a new Parser instance.
	 * @param tokens The token list to interpret.
	 */
	public function new(tokens:Array<Token>, ?ioType:IOType) {
		this.tokens = tokens;
		this.ioType = ioType ?? ASCII;
	}

	/**
	 * Executes the Brainfuck program.
	 * Returns the printed output as a String.
	 */
	public function run():String {
		buffer = Bytes.alloc(3000);
		position = 0;
		ptr = 0;

		// stores matching bracket pairs for fast jumps
		var jumpMap:IntMap<Int> = new IntMap<Int>();
		var stack:Array<UInt> = [];

		var output:StringBuf = new StringBuf();

		// preprocess loop pairs
		for (i => token in tokens) {
			switch (token) {
				case TLBracket(column, line):
					stack.push(i);

				case TRBracket(column, line):
					if (stack.length == 0)
						throw new InfoError('Unexpected \"]\"', line, column);

					final start = stack.pop();
					jumpMap.set(start, i);
					jumpMap.set(i, start);

				case _:
					// do nothing
			}
		}

		if (stack.length != 0)
			throw new Error('Expected \"]\"');

		while (position < tokens.length) {
			final curToken = tokens[position];

			switch (curToken) {
				case TAdd(column, line):
					buffer.set(ptr, buffer.fastGet(ptr) + 1);

				case TSub(column, line):
					buffer.set(ptr, buffer.fastGet(ptr) - 1);

				case TIncrement(column, line):
					ptr++;

				case TDecrement(column, line):
					ptr--;
					if (ptr < 0)
						throw new InfoError('Out of bounds', line, column);

				case TLBracket(column, line):
					if (buffer.fastGet(ptr) == 0)
						position = jumpMap.get(position);

				case TRBracket(column, line):
					if (buffer.fastGet(ptr) != 0)
						position = jumpMap.get(position);

				case TDot(column, line):
					switch (ioType) {
						case DECIMAL:
							output.add(buffer.fastGet(ptr));
							output.add(' ');
						case ASCII:
							output.add(String.fromCharCode(buffer.fastGet(ptr)));
					}

				case TComma(column, line):
					switch (ioType) {
						case DECIMAL:
							var input:String = Sys.stdin().readLine();
							var parsedInput:Null<Int> = Std.parseInt(input);

							if (parsedInput == null)
								throw new Error('Invalid input ${input}');

							buffer.set(ptr, parsedInput);
						case ASCII:
							var input:Int = Sys.stdin().readByte();

							// only grabs the first char from the string
							buffer.set(ptr, input);
					}

				case _:
					// do nothin
			}

			position++;
		}

		return output.toString();
	}
}
