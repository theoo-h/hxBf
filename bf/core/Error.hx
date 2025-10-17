package bf.core;

/**
 * Base error type for Brainfuck-related exceptions.
 * 
 * Used for general runtime or parsing errors.
 */
class Error extends haxe.Exception {
	/**
	 * Creates a new error instance with a message.
	 * @param msg Description of what went wrong.
	 */
	public function new(msg:String) {
		super(msg);
	}
}
