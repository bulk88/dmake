#disabling the jump stubs since they weren't being used due to dllimport
#and weren't being optimized out of the binary, IDK why they weren't optimized
#out by linker if not used, maybe the "comdat" feature is needed or
#_set_new_handler and _set_new_mode should be in different .s/.o files as if
#dlltool made them (dlltool stores 1 func per .o in the .a, not 2 like here)

#.section .text
#.globl	__set_new_handler
#__set_new_handler:
#	jmp	*__imp___set_new_handler

.section .idata$5
.globl __imp___set_new_handler
__imp___set_new_handler:
	.rva	.string_set_new_handler

#.section .text
#.globl	__set_new_mode
#__set_new_mode:
#	jmp	*__imp___set_new_mode

.section .idata$7
	.rva	 __head_libmsvcrt_a



.section .idata$5
.globl __imp___set_new_mode
__imp___set_new_mode:
	.rva	.string_set_new_mode


.section .idata$4
	.rva	.string_set_new_handler

.section .idata$4
	.rva	.string_set_new_mode

#1=aligned to 2 bytes, old gases dont have this and therefore
#warn "Warning: unknown section attribute '1'"
.section .idata$6, "1"
.string_set_new_handler:
	.short	0
	.ascii	"?_set_new_handler@@YAP6AHI@ZP6AHI@Z@Z\000"

#1=aligned to 2 bytes
.section .idata$6, "1"
.string_set_new_mode:
	.short	0
	.ascii	"?_set_new_mode@@YAHH@Z\000"
