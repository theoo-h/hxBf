package bf.core;

/**
 * Represents the type of input/output the Brainfuck interpreter uses.
 * 
 * DECIMAL: input/output is treated as numbers (e.g., 65 → 65 in memory).
 * ASCII: input/output is treated as characters (e.g., 'A' → 65 in memory).
 */
enum IOType {
	/**
	 * Decimal mode.
	 * Read/write numbers as integers.
	 */
	DECIMAL;

	/**
	 * ASCII mode.
	 * Read/write characters as their char codes.
	 */
	ASCII;
}
