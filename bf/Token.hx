package bf;

/**
 * Represents all possible tokens in Brainfuck.
 * Each token stores its position info (column and line);
 * 
 * Mainly used by `Lexer` before passing tokens to the `Parser`.
 */
enum Token {
	/**
	 * Represents "+".
	 * Increases the value on the current memory cell.
	 */
	TAdd(column:UInt, line:UInt);

	/**
	 * Represents "-".
	 * Decreases the value on the current memory cell.
	 */
	TSub(column:UInt, line:UInt);

	/**
	 * Represents ">".
	 * Moves the memory pointer to the right.
	 */
	TIncrement(column:UInt, line:UInt);

	/**
	 * Represents "<".
	 * Moves the memory pointer to the left.
	 */
	TDecrement(column:UInt, line:UInt);

	/**
	 * Represents "[".
	 * Starts a loop.
	 */
	TLBracket(column:UInt, line:UInt);

	/**
	 * Represents "]".
	 * Ends a loop.
	 */
	TRBracket(column:UInt, line:UInt);

	/**
	 * Represents ".".
	 * Print the current cell value to the console.
	 * Output depends on the output type.
	 */
	TDot(column:UInt, line:UInt);

	/**
	 * Represents ",".
	 * Reads the console input and stores it on the current cell.
	 * Output depends on the output type.
	 */
	TComma(column:UInt, line:UInt);
}
