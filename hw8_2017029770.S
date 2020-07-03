	.text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register; it is caller saved.
 */
	.globl thread_switch
thread_switch:
	
	#save current_thread context
	pushal

	#esp switch
	#save current_thread in (eax:return address container)
	movl current_thread, %eax
	#move present esp to current_thread sp
	movl %esp, (%eax)

	#approximate next_thread
	movl next_thread, %eax
	#next_thread struct to esp register
	movl (%eax), %esp

	#load next_thread state
	popal

	#swap thread each other
	movl next_thread, %eax
	movl %eax, current_thread
	movl %eax, next_thread

	ret				/* pop return address from stack */
