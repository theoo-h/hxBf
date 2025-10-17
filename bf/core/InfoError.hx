package bf.core;

/**
 * Error type that includes line and column info.
 * 
 * Used for Brainfuck parsing/runtime errors where position matters.
 */
class InfoError extends haxe.Exception {
	/**
	 * Line number where the exception ocurred.
	 */
	public var line:Int;

	/**
	 * Column number where the exception ocurred.
	 */
	public var column:Int;

	/**
	 * Creates a new InfoError.
	 * @param msg Description of the error.
	 * @param line Line number in the source.
	 * @param column Column number in the source.
	 */
	public function new(msg:String, line:Int, column:Int) {
		super('${msg} (at line $line, char $column)');
		this.line = line;
		this.column = column;
	}
}
