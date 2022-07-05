package geco.test;

import java.io.FileReader;

import org.antlr.runtime.ANTLRReaderStream;
//import org.antlr.runtime.CommonTokenStream;

import geco.model.Instruction;
import geco.parser.*;

public class ParserTester {

	public static void main(String[] args) {
		GecoParser parser;
	  	String fileIn = ".\\resources\\input.file";
//  	String fileout = ".\\resources\\output.file";

		try {
			// 1. Lexer init
				GecoLexer lexer = new GecoLexer(new ANTLRReaderStream(new FileReader(fileIn
			// 2. Parser init
				parser = new GecoParser(lexer);

			// 3. Launch parser
			parser.start();

			// 4. Results of the parser analysis
			Environment env =	parser.getEnvironment();

			// 5. Print out # of analyzed instructions
			System.out.println("Number of instructions analyzed: " + env.getNInstruction());

			// 6. Print out # of detected errors
			System.out.println("\nNumber of detected errors: " + env.getErrorList().size());
			// 7. Error list
			for (int i=0;i<env.getErrorList().size();i++) {
				System.out.println((i+1) + ".\t" + parser.getErrorList().get(i));
			}

			// 8. Reformat of detected Instructions
			System.out.println("\nList of instructions:");
			for (int i=0;i<env.getInstructionList().size();i++) {
				doSomethingWithInstruction (env.getInstructionList().get(i));
			}

		} catch (Exception e) {
				System.out.println ("Parsing aborted\n\n");
				e.printStackTrace();
			}
	  }


	// in this case I just print out instruction text
	static void doSomethingWithInstruction (Instruction instr) {
		System.out.println(instr.getSeguence() + "\tid:" + instr.getId() +
												"\tinstr:" + instr.getInstructionName());

// terst differences between toString and toMultilineString
//		System.out.println(instr.toString());
		System.out.println(instr.toMultilineString());
		System.out.println();
	}
}
