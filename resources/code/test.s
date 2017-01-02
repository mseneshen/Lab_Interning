#---------------------------------------------------------------
# Student Test File for Interning Lab
# Author: Taylor Lloyd
# Date: July 12, 2012
#---------------------------------------------------------------


#-------------------------------------------
# Bug fixing - Nov 23, 2014
# 
# Author: Alejandro Ramirez
# 
# Added a check to avoid problems
# with strings that have not been
# interned. 
#
#-------------------------------------------

.data

instructions:
	.asciiz	"Enter 'i' to intern, 'g' to retrieve, 'f' to intern a file, 'q' to quit:"
internText:
	.asciiz	"String to intern:"
internReturn:
	.asciiz "Identifier:"
fInternText:
	.asciiz	"File to intern:"
sErr:
	.asciiz "String has not been interned.\n"
fErr:
	.asciiz "Error opening file.\n"
fInternReturn:
	.asciiz "Identifiers:\n"
getText:
	.asciiz	"Identifier to retrieve:"
getReturn:
	.asciiz "String:"
err:	.asciiz "Unrecognized command.\n"
nlStr:	.asciiz "\n"
cmd:	.space 256
	.align 2
fileMem:.space 2048

.text
main:
	mainLoop:
		#instructions message
		la	$a0 instructions
		li	$v0 4
		syscall

		#read input
		la	$a0 cmd
		li	$a1 16
		li	$v0 8
		syscall

		#intern?
		lb	$t0 cmd
		li	$t1 'i'
		beq	$t0 $t1 intern

		#file intern?
		lb	$t0 cmd
		li	$t1 'f'
		beq	$t0 $t1 file

		#retrieve?
		li	$t1 'g'
		beq	$t0 $t1 get

		#quit?
		li	$t1 'q'
		beq	$t0 $t1 die

		#error & loop back
		la	$a0 err
		li	$v0 4
		syscall
		j	mainLoop

	intern:
		#prompt
		la	$a0 internText
		li	$v0 4
		syscall
		
		#allocate space for string
		li	$a0 256
		li	$v0 9
		syscall

		#read string to newly allocated space
		move	$a0 $v0
		li	$a1 256
		li	$v0 8
		syscall
		move	$s0 $a0

		#drop newline from end
		li	$t0 0x0A
		move	$t1 $s0
		intern_drop_nl:
			lb	$t2 0($t1)
			beqz	$t2 intern_drop_done
			beq	$t0 $t2 intern_store
			addi	$t1 $t1 1
			j	intern_drop_nl
		intern_store:
			sb	$0 0($t1)
		intern_drop_done:

		#prettify
		la	$a0 internReturn
		li	$v0 4
		syscall

		#call internString
		move	$a0 $s0
		jal	internString

		#print identifier
		move	$a0 $v0
		li	$v0 1
		syscall

		#print newline
		la	$a0 nlStr
		li	$v0 4
		syscall

		j	mainLoop
	file:
		#prompt
		la	$a0 fInternText
		li	$v0 4
		syscall

		#read filename
		la	$a0 cmd
		li	$a1 256
		li	$v0 8
		syscall
		
		#drop newline from end
		li	$t0 0x0A
		la	$t1 cmd
		file_drop_nl:
			lb	$t2 0($t1)
			beqz	$t2 file_drop_done
			beq	$t0 $t2 file_store
			addi	$t1 $t1 1
			j	file_drop_nl
		file_store:
			sb	$0 0($t1)
		file_drop_done:
		

		li	$a1 0		#read
		li	$a2 0x0644
		li	$v0 13
		syscall
	
		li	$t0 -1
		beq	$v0 $t0 printFileErr

		move	$a0 $v0
		la	$a1 fileMem
		li	$a2 2048
		li	$v0 14
		syscall

		#Place EOT at end of file
		add	$t0 $a1 $v0
		li	$t1 4	#EOT
		sb	$t1 0($t0)

		#Close file
		li	$v0 16
		syscall

		#prettify
		la	$a0 fInternReturn
		li	$v0 4
		syscall

		#call internFile
		la	$a0 fileMem
		jal	internFile
		
		#print all identifiers
		move	$t0 $v0
		move	$t1 $v1
		fileIDPrint:
			lw	$a0 0($t0)
			li	$v0 1
			syscall

			#print newline
			la	$a0 nlStr
			li	$v0 4
			syscall
			
			addi	$t0 $t0 4
			addi	$t1 $t1 -1

			bgtz	$t1 fileIDPrint

		j	mainLoop

	get:
		#prompt
		la	$a0 getText
		li	$v0 4
		syscall

		#read number
		li	$v0 5
		syscall
		move	$s0 $v0

		#prettify
		la	$a0 getReturn
		li	$v0 4
		syscall

		#call getInternedString
		move	$a0 $s0
		jal	getInternedString

		#check if it is not zero
		beqz 	$v0 printStringErr 

		#print it
		move	$a0 $v0
		li	$v0 4
		syscall

		#print newline
		la	$a0 nlStr
		li	$v0 4
		syscall

		j	mainLoop

	printStringErr: 
		la	$a0 sErr
		li 	$v0 4
		syscall
		j 	mainLoop

	printFileErr:
		la	$a0 fErr
		li	$v0 4
		syscall
		j	mainLoop

	die:
		li	$v0 10
		syscall
		
######################## STUDENT CODE BEGINS HERE ##########################
